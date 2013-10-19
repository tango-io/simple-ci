require 'spec_helper'

describe SidekiqStatus do
  
  let(:status) { SidekiqStatus.new }

  before do
    Sidekiq.stub(:redis).and_return(10)
  end

  it 'has a total workers attribute' do
    expect(status.total).to eq(25)
  end

  it 'has a total of busy workers attribute' do
    expect(status.busy).to eq(10)
  end

  it 'has a total of available workers attribute' do
    expect(status.available).to eq(15)
  end

end
