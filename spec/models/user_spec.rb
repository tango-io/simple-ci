require 'spec_helper'

describe User do

  context 'validations' do
    it { should validate_presence_of(:name)     }
    it { should validate_presence_of(:uid)      }
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:nickname) }
    it { should have_and_belong_to_many(:repositories) }
    it { should validate_uniqueness_of(:uid)      }
    it { should validate_uniqueness_of(:nickname) }
  end

  context 'methods' do

    let(:repos) { repositories }

    let(:user) { create_user(auth) }
    it 'create a user from github' do
      user.save
      expect(User.count).to eq(1)
    end

    it 'get the public repositories of a user' do
      user.save
      objects = initialize_repositories(repos)
      user.stub_chain(:open, :read).and_return(repos.to_json)
      expect(user.public_repositories.first.name).to eq(objects.first.name)
      expect(user.public_repositories.count).to eq(objects.count)
    end

  end
end
