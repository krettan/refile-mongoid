# Refile::Mongoid

[Mongoid](http://mongoid.org/) extension for [Refile](https://github.com/refile/refile).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'refile-mongoid', git: 'git@github.com:krettan/refile-mongoid.git'
```

## Usage

```ruby
require "refile/mongoid"

class User
  include Mongoid::Document
  extend Refile::Mongoid::Attachment

  attachment :profile_image
end
```

## License

[MIT](/LICENSE.txt)
