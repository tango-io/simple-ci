require 'spec_helper'

describe User do

  context 'validations' do
    it { should validate_presence_of(:name)     }
    it { should validate_presence_of(:uid)      }
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:nickname) }

    it { should validate_uniqueness_of(:uid)      }
    it { should validate_uniqueness_of(:nickname) }
  end

  context 'methods' do

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

    let(:repos) do
      [
        { 'name' => Faker::Lorem.sentence },
        { 'name' => Faker::Lorem.sentence },
        { 'name' => Faker::Lorem.sentence },
        { 'name' => Faker::Lorem.sentence }
      ]
    end

    it 'create a user from github' do
      user = User.build_from_omniauth auth
      user.save
      expect(User.count).to eq(1)
    end

    it 'get the public repositories of a user' do
      user = User.build_from_omniauth auth
      user.save
      objects = repos.map do |repo|
        Repository.find_or_initialize_by(
          uid:   repo['id'],
          name: repo['name'],
          url:  repo['url'])
      end
      user.stub_chain(:open, :read).and_return(repos.to_json)
      expect(user.public_repositories).to eq(objects)
    end

  end
end
