require 'spec_helper'

describe Repository do
  context 'validations' do
   it { should validate_presence_of(:name) }
   it { should validate_presence_of(:url) }
   it { should validate_uniqueness_of(:url) }
   it { should have_and_belong_to_many(:users) }
  end
end
