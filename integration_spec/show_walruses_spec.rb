require_relative './capybara_helper'

feature 'Create a walrus', :js => true  do
  include CapybaraHelper

  background do
    walrus_exists
    on_home_page
  end

  scenario 'can create a walrus' do
    click_on 'Show Walruses'
    page.should have_content WalrusName
  end
end


