if ENV['TRAVIS']
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  SimpleCov.start do
    add_filter "spec/"
  end
end

require 'active_record'
require 'activerecord-mysql-pkdump'

TEST_DATABASE = 'activerecord_mysql_pkdump_test'

RSpec.configure do |config|
  config.before(:all) do
    ActiveRecord::Base.establish_connection(
      adapter: 'mysql2',
      database: TEST_DATABASE,
    )
  end

  config.before(:each) do
    clean_database
  end
end

def mysql
  client = nil
  retval = nil

  begin
    client = Mysql2::Client.new(
      host: 'localhost',
      username: 'root',
    )

    retval = yield(client)
  ensure
    client.close if client
  end

  retval
end

def create_database(client)
  client.query("CREATE DATABASE #{TEST_DATABASE}")
end

def drop_database(client)
  client.query("DROP DATABASE IF EXISTS #{TEST_DATABASE}")
end

def clean_database
  mysql do |client|
    drop_database(client)
    create_database(client)
  end
end

def create_tables(pk_name, pk_type)
  mysql do |client|
    client.query("USE #{TEST_DATABASE}")

    client.query(<<-SQL)
      CREATE TABLE books (
        `#{pk_name}` #{pk_type},
        `title` varchar(255) NOT NULL,
        `author_id` int(10) unsigned NOT NULL,
        `created_at` datetime DEFAULT NULL,
        `updated_at` datetime DEFAULT NULL
      ) DEFAULT CHARSET=utf8
    SQL

    client.query(<<-SQL)
      CREATE TABLE authors (
        `#{pk_name}` #{pk_type},
        `name` varchar(255) NOT NULL,
        `created_at` datetime DEFAULT NULL,
        `updated_at` datetime DEFAULT NULL
      ) DEFAULT CHARSET=utf8;
    SQL
  end
end

def dump
  conn = ActiveRecord::Base.connection
  stream = StringIO.new
  ActiveRecord::SchemaDumper.dump(conn, stream)
  stream.string.gsub(/^#.*$/, '').strip
end
