require 'spec_helper'

feature 'Running tests' do
  before do
    visit root_path
  end

  scenario 'from the homepage' do
    #fill_in('github_url', with: 'https://github.com/TheNaoX/active_component')
    #page.should have_content('Modify your script')
    #click_button('RUN')
    #page.should have_content('Log')
  end

end
