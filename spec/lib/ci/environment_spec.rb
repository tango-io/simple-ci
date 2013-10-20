require 'spec_helper'

describe Ci::Environment, 'initialize' do

  let(:environment) { Ci::Environment.new }

  before do
    Ci::SSH.stub(:new).and_return(double(
      user: Faker::Name.name,
      host: Faker::Internet.ip_v4_address
    ))
  end

  it 'generates a session on boot' do
    expect(environment.session).to be_present
  end

end

describe Ci::Environment, 'uploader' do

  let(:environment) { Ci::Environment.new }

  it 'uploads a file from a given script' do
    expect(environment.session).to be_present
  end

end
