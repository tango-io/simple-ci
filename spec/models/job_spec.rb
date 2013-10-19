require 'spec_helper'

describe Job, 'validations' do
  it { should validate_presence_of(:session_id) }
  it { should validate_presence_of(:github_url) }
  it { should validate_presence_of(:log_output) }
end
