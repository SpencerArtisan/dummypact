require 'test_environment'
require 'sinatra'
require 'server'
require 'capybara/rspec'
require 'capybara-webkit'

Capybara.app = Sinatra::Application
Capybara.javascript_driver = :webkit

feature 'Smoke test', :js => true  do
  scenario 'Smoke test' do
    visit '/'
    click_on 'Create Walrus'
    fill_in 'name', :with => 'Walter'
    click_on 'Save'

    click_on 'Show Walruses'
    page.should have_content 'Walter'
  end
end
