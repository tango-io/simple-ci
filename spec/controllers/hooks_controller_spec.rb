require 'spec_helper'

describe HooksController do
  let(:repo)

  it 'creates a job for the added repository' do
    options = { payload: { repository: { id: '123456', url: ''} } }
    post :github, options, format: :json
    response.message.should eq('Successfully enqueued test')
  end

  it 'cannot create a job with wrong data ' do
    options = { bad: { repository: { id: '123456'} } }
    post :github, options, format: :json
    response.message.should eq('Something went wrong')
  end
end
