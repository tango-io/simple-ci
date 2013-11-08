require 'spec_helper'

feature 'dashboard' do

  let(:repository) do
    Fabricate(
      :repository,
      uid: user.uid,
      name: Faker::Internet.domain_word,
      url: Faker::Internet.url,
      activated: true
    )
  end

  let(:user) { create_user(auth) }

  let(:repository_list) { initialize_repositories(repositories) }

  before do
    repository_list << repository
    User.any_instance.stub(:public_repositories).and_return(repository_list)
    user.repositories.push(repository)
    page.set_rack_session(:user_id => user.id)
    visit dashboard_index_path
  end

  scenario 'load previously added repositories ' do
    find("tr[@id='#{repository.name}']")
  end

  scenario 'add new repository', :js do
    click_link 'add repositories'
    repo = repository_list.sample
    within('#add-repos-modal') do
      find("#on_#{repo.name}").click
      click_button 'Close'
    end
    visit dashboard_index_path
    find("##{repo.name}")
  end

  scenario 'delete repository', :js do
    page.should have_content(repository.name)
    click_link 'add repositories'
    within('#add-repos-modal') do
      find("#off_#{repository.name}").click
      click_button 'Close'
    end
    visit dashboard_index_path
    page.should_not have_content(repository.name)
  end

end
