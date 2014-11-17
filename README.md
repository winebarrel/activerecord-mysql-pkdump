# Activerecord::Mysql::Pkdump

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord-mysql-pkdump'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord-mysql-pkdump

## Usage

```ruby
require 'active_record'
require 'activerecord-mysql-pkdump'

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  database: '...',
)

ActiveRecord::SchemaDumper.dump
#=> ...
#   create_table "items", primary_key: "my_id", id: 'bigint(20) auto_increment PRIMARY KEY', force: true do |t|
#     ...
#   end
#   ...
```