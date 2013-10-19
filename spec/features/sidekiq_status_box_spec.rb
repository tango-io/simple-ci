require 'spec_helper'

feature 'Sidekiq status box' do
  include AjaxSupport

  before do
    visit root_path
  end

  it 'has a div for display the status', :js do
    expect(page).to have_css('.workers-status-box')
  end

  it 'displays total workers', :js do
    text = find('.js-total').text
    expect(text).to eq('0')
  end

  it 'displays the amount of busy workers', :js do
    text = find('.js-busy').text
    expect(text).to eq('0')
  end

  it 'displays the amounts of available workers', :js do
    text = find('.js-available').text
    expect(text).to eq('0')
  end
end
