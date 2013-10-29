require 'spec_helper'

describe Repository do
  context 'validations' do
   it { should validate_presence_of(:name) }
   it { should validate_presence_of(:url) }
   it { should validate_presence_of(:user_id) }
   it { should validate_uniqueness_of(:url).scoped_to(:user_id) }
  end
end
