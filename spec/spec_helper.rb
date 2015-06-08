require "refile/mongoid"
require "mongoid"
require "tmpdir"

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.formatter = "documentation"
end

Mongoid.load!('./spec/config/mongoid.yml')

require_relative "support/refile"
