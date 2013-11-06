require 'spec_helper'

describe Repository do
  context 'validations' do
    before :each do
      Repository.skip_callback(:create, :before, :subscribe_hooks)
      Repository.skip_callback(:destroy, :before, :unsubscribe_hooks)
    end
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:user_id) }
    it { should validate_uniqueness_of(:url) }
  end
  context 'methods' do
    let(:user){ Fabricate :user}
    let(:repository){
      Repository.create(
        name: 'simple-ci',
        url: 'www.sample.com',
        user_id: user.id)
    }

    it 'hooks_url return an url og github API' do
     repository.hooks_url.should eq("https://api.github.com/repos/#{user.nickname}/#{repository.name}/hooks")
    end
  end
end
