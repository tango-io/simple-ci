require 'spec_helper'

feature 'Sidekiq status box' do

  before do
    Sidekiq.stub(:redis).and_return(7)
    visit root_path
  end

  # TODO add ajax wait here
 
  it 'has a div for display the status', :js do
    expect(page).to have_css('.workers-status-box')
  end

  it 'displays total workers', :js do
    text = find('.js-total').text
    expect(text).to eq('25')
  end

  it 'displays the amount of busy workers', :js do
    text = find('.js-busy').text
    expect(text).to eq('7')
  end

  it 'displays the amounts of available workers', :js do
    text = find('.js-available').text
    expect(text).to eq('18')
  end
end
