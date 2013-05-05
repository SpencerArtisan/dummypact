require_relative './capybara_helper'

feature 'Visit the home page', :js => true  do
  include CapybaraHelper

  background do
    on_home_page
  end

  scenario 'can see the home page' do
    page.should have_content 'Skeleton'
  end
end
