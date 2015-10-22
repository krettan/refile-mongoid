Gem::Specification.new do |gem|
  gem.name          = "refile-mongoid"
  gem.version       = "0.0.1"

  gem.required_ruby_version = ">= 2.1.0"

  gem.summary       = "MongoID integration of the Refile gem"
  gem.description   = "Allow MongoID to play nicely with refile"
  gem.homepage      = "https://github.com/krettan/refile-mongoid"

  gem.authors       = ["Carl Retzner"]
  gem.email         = ["krettan@gmail.com"]

  gem.license       = "MIT"

  gem.files         = Dir["README.md", "LICENSE.txt", "lib/**/*"]
  gem.require_path  = "lib"

  gem.add_dependency "refile", "~> 0.5"
  gem.add_dependency 'mongoid', '>= 4.0'

  gem.add_development_dependency "rake", "~> 10.0"
  gem.add_development_dependency "rspec", "~> 3.1"
  gem.add_development_dependency 'mongoid-rspec', '~> 2.1'
end
