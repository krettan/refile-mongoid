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
    end
  end
end
