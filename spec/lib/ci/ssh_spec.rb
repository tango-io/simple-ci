require 'spec_helper'

describe Ci::SSH, 'initializer' do

  it 'requires values for being initialized' do
    expect{ Ci::SSH.new }.to raise_error
  end
  
  it 'accepts only host, user, port, and password' do
    expect { Ci::SSH.new(foo: 'bar') }.to raise_error
  end

  it 'assigns the values to attribute readers' do
    connection = Ci::SSH.new(
      user:     Faker::Name.name,
      password: Faker::Internet.password,
      host:     Faker::Internet.ip_v4_address,
      port:     22
    )
    expect(connection.user).to be_present
    expect(connection.password).to be_present
    expect(connection.host).to be_present
    expect(connection.port).to be_present
  end

end

describe Ci::SSH, 'connect' do
  let(:connection) do
    Ci::SSH.new(
      user:     Faker::Name.name,
      password: Faker::Internet.password,
      host:     Faker::Internet.ip_v4_address,
      port:     22
    )
  end

  before do
    Net::SSH.stub(:start).and_return(true)
  end
  
  it 'connects via ssh to the provided server' do
    expect(connection.connect).to be_true
  end

  it 'raises an error when a user executes a command without arguments' do
    expect{ connection.exec }.to raise_error
  end

  it 'executes a command in the remote server' do
    connection.stub(:exec).and_return(true)
    expect(connection.exec('ls -al')).to be_true
  end

end
