require 'sinatra'
require 'sequel'
require 'sqlite3'
require 'environment'
require 'log'

configure :development, :staging, :production do
  DB = Sequel::connect('sqlite://artisan.db')
end

configure :test do
  DB = Sequel::sqlite
end

Sequel::Model.db = DB
Sequel.extension :migration
Sequel::Migrator.run DB, 'migrations'
DB.loggers << Log

