require 'spec_helper'

feature 'dashboard' do

  let(:auth) do
    {
      'uid' => '1337',
      'provider' => 'github',
      'info' => {
        'name' => Faker::Name.name,
        'nickname' => Faker::Internet.user_name
      }
    }
  end

  let(:user) do
    user = User.build_from_omniauth auth
    user.save
    user
  end

  let!(:repository) do
    Fabricate(:repository,
              uid: user.uid,
              name: Faker::Internet.user_name,
              url: Faker::Internet.url,
              user_id: user.id)
  end

  def public_repositories
    repositories = []
    5.times do
      repositories << Fabricate.build(:repository,
                                     uid: user.uid,
                                     name: Faker::Internet.user_name,
                                     url: Faker::Internet.url,
                                     user_id: user.id)
    end
    repositories
  end

  before() do
    User.any_instance.stub(:public_repositories).and_return(public_repositories)
    page.set_rack_session(:user_id => user.id)
    visit dashboard_index_path
  end

  scenario 'local repositories list' do
  end
end
