require 'spec_helper'

feature 'dashboard share repository' do

  def github_auth
    {
      'uid' => Random.new.rand(9999).to_s,
      'provider' => 'github',
      'info' => {
        'name' => Faker::Name.name,
        'nickname' => Faker::Internet.user_name
      }
    }
  end

  def create_user
    user = User.build_from_omniauth github_auth
    user.save
    user
  end

  let(:repository_list) { public_repositories }

  def public_repo
    Fabricate.build(
      :repository,
      name: Faker::Internet.domain_word,
      url: Faker::Internet.url
    )
  end

  def public_repositories
    repositories = []
    5.times { repositories << public_repo }
    repositories
  end

  def add_repository(user, repository)
    repo = Repository.find_by_url(repository.url)
    user.repositories.push(repo)
  end

  scenario 'add new repository and all show', :js do
    bar = create_user
    User.any_instance.stub(:public_repositories) do
      repository_list.map do |repo|
        add_repository(bar, repo) unless Repository.find_by_url(repo.url).nil?
        Repository.find_or_initialize_by(
          uid:  repo['id'],
          name: repo['name'],
          url:  repo['url']
        )
      end
    end
    foo = create_user
    page.set_rack_session(:user_id => foo.id)
    visit dashboard_index_path
    click_link 'add repositories'
    select_repo = repository_list.sample
    within('#add-repos-modal') do
      find("#on_#{select_repo.name}").click
      click_button 'Close'
    end
    page.set_rack_session(:user_id => bar.id)
    visit dashboard_index_path
    visit dashboard_index_path
    find("##{select_repo.name}")
  end

end
