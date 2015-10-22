require 'refile'
require 'mongoid'

module Refile
  module Mongoid
    module Attachment
      include Refile::Attachment

      def attachment(name, raise_errors: false, **options)
        super
        attacher = "#{name}_attacher"
        field "#{name}_id".to_sym, type: String

        before_save do
          send(attacher).store!
        end

        after_destroy do
          send(attacher).delete!
        end

        before_validation do
          if send(attacher).present?
            send(attacher).valid?
            send(attacher).errors.each do |error|
              errors.add(name, error)
            end
          end
        end
      end

      def accepts_attachments_for(association_name, attachment: :file, append: false)
        association = reflect_on_association(association_name)
        name = "#{association_name}_#{attachment.to_s.pluralize}"

        mod = Module.new do
          define_method :"#{name}_attachment_definition" do
            association.klass.send("#{attachment}_attachment_definition")
          end

          define_method :"#{name}_data" do
            if send(association_name).all? { |record| record.send("#{attachment}_attacher").valid? }
              send(association_name).map(&:"#{attachment}_data").select(&:present?)
            end
          end

          define_method :"#{name}" do
            send(association_name).map(&attachment)
          end

          define_method :"#{name}=" do |files|
            cache, files = files.partition { |file| file.is_a?(String) }

            cache = Refile.parse_json(cache.first)

            if not append and (files.present? or cache.present?)
              send("#{association_name}=", [])
            end

            if files.empty? and cache.present?
              cache.select(&:present?).each do |file|
                send(association_name).build(attachment => file.to_json)
              end
            else
              files.select(&:present?).each do |file|
                send(association_name).build(attachment => file)
              end
            end
          end
        end

        include mod
      end
    end
  end
end
