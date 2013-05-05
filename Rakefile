require 'rspec/core/rake_task'
require 'rake'

desc "Run specs"
RSpec::Core::RakeTask.new(:unit)

desc "Run integration specs"
RSpec::Core::RakeTask.new(:integration) do |t|
  t.pattern = "./integration_spec/*_spec.rb"
end

desc "Run smoke specs"
RSpec::Core::RakeTask.new(:smoke) do |t|
  t.pattern = "./smoke_spec/*_spec.rb"
end

desc "Run all specs"
RSpec::Core::RakeTask.new(:all) do |t|
  t.pattern = "./*/*_spec.rb"
end

desc "Run server"
task :server do
  system("rackup")
end

desc "Run server with shotgun to pick up code changes"
task :shotgun do
  system("shotgun -p 80 config.ru")
end

task :dbreset do
  require 'environment'
  require 'database'
  require 'sequel'
  puts 'MIGRATING DATABASE'
  Sequel.extension :migration
  Sequel::Migrator.run(DB, "migrations", :target => 0)
  Sequel::Migrator.run(DB, "migrations")
end

