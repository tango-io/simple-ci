require 'spec_helper'

describe JobsController do

  before do
    RunTestsWorker.stub(:jobs).and_return([])
  end

  it 'triggers the CI work' do
    post :create, format: :json, job: { github_url: Faker::Internet.url, script: [ Faker::Lorem.sentence ] }
    expect(response.status).to eq(200)
    expect(RunTestsWorker.jobs.size).to eq(1)
  end

  it 'raises an error if there is not job params present' do
    expect { post :create, format: :json }.to raise_error
  end

  it 'does not trigger any job if the given values are wrong' do
    post :create, format: :json, job: { wrong_key: Faker::Lorem.sentence }
    expect(response.status).to eq(422)
    expect(RunTestsWorker.jobs.size).to eq(0)
  end

end
