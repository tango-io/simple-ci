require 'spec_helper'

feature 'dashboard share repository' do

  let(:repository_list) { initialize_repositories(repositories) }


  scenario 'add new repository and all show', :js do
    user = create_user(auth)
    User.any_instance.stub(:public_repositories) do
      repository_list.map do |repo|
        add_repository(user, repo) unless Repository.find_by_url(repo.url).nil?
        Repository.find_or_initialize_by(
          uid:  repo['id'],
          name: repo['name'],
          url:  repo['url']
        )
      end
    end
    something = create_user(auth)
    page.set_rack_session(:user_id => something.id)
    visit dashboard_index_path
    click_link 'add repositories'
    select_repo = repository_list.sample
    within('#add-repos-modal') do
      find("#on_#{select_repo.name}").click
      click_button 'Close'
    end
    page.set_rack_session(:user_id => something.id)
    visit dashboard_index_path
    visit dashboard_index_path
    find("##{select_repo.name}")
  end

end
