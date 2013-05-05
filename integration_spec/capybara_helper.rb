require_relative 'vcr_setup'
require 'test_environment'
require 'in_memory_database'
require 'server'
require 'capybara/rspec'
require 'capybara-webkit'

Capybara.app = Sinatra::Application
Capybara.javascript_driver = :webkit
Capybara.default_wait_time = 15

WalrusName = 'Walter'

module CapybaraHelper
  include Capybara::DSL

  def on_home_page
    visit '/'
  end

  def wait_for_page_to_load
    page.current_url
  end

  def walrus_exists
    @walrus = Walrus.new(:name => WalrusName).save
  end
end
