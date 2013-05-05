require_relative './capybara_helper'

feature 'Create a walrus', :js => true  do
  include CapybaraHelper

  background do
    on_home_page
  end

  scenario 'can create a walrus' do
    click_on 'Create Walrus'
    fill_in 'name', :with => 'William'
    click_on 'Save'

    wait_for_page_to_load
    Walrus[:name => 'William'].should exist
  end
end

