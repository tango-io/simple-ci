require 'spec_helper'

feature 'dashboard' do

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

  let(:foo) { create_user }

  let!(:foo_repository) do
    Fabricate(
      :repository,
      uid: foo.uid,
      name: Faker::Internet.domain_word,
      url: Faker::Internet.url,
      activated: true
    )
  end

  let(:repository_list) { public_repositories }

  def public_repo
    Fabricate.build(
      :repository,
      uid: foo.uid,
      name: Faker::Internet.domain_word,
      url: Faker::Internet.url
    )
  end

  def public_repositories
    repositories = []
    repositories << foo_repository
    5.times { repositories << public_repo }
    repositories
  end

  before do
    User.any_instance.stub(:public_repositories).and_return(repository_list)
    foo.repositories.push(foo_repository)
    page.set_rack_session(:user_id => foo.id)
    visit dashboard_index_path
  end

  scenario 'load previously added repositories ' do
    find("tr[@id='#{foo_repository.name}']")
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
    click_link 'add repositories'
    within('#add-repos-modal') do
      find("#off_#{foo_repository.name}").click
      click_button 'Close'
    end
    visit dashboard_index_path
    page.should_not have_content(foo_repository.name)
  end
end
