require 'database'

RSpec.configure do |config|
  config.before(:each) do
    reset_db
  end
end

def reset_db
  Sequel.extension :migration
  Sequel::Migrator.run(DB, "migrations", :target => 0)
  Sequel::Migrator.run(DB, "migrations")
end

