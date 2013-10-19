require 'spec_helper'

describe JobsController do

  it 'triggers the CI work' do
    post :create
    expect(RunTestsWorker.jobs.size).to eq(1)
  end

end
