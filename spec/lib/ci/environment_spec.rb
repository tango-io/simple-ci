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

  it 'receives two parameters' do
    expect { environment.upload_script }.to raise_error
  end

  it 'generates the script from the given two parameters' do
    environment.stub(:exec).and_return(true)
    expect(
      environment.upload_script("~/script.sh", "echo 'Foo'")
    ).to be_true
  end

end

describe Ci::Environment, 'exec' do

  let(:environment) { Ci::Environment.new }

  it 'executes a  command' do
    environment.session.stub(:exec).and_return(true)
    expect(environment.session).to receive(:exec)
    environment.exec('some command')
  end

end
