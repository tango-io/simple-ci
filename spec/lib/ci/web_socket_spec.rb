require 'spec_helper'

describe Ci::WebSocket do
  let(:ws) { Ci::WebSocket.new }

  before do
    ws.client.stub(:publish).and_return(true)
  end

  it 'initializes the websocket connection' do
    expect {
      Ci::WebSocket.new
    }.to_not raise_error
  end

  it 'has the url for the connection' do
    expect(ws.url).to eq('http://localhost:9292/faye')
  end

  it 'sends a message through the websocket' do
    expect(ws.client).to receive(:publish)
    ws.publish(
      channel: 'foo',
      data: {
        bar: 'bar'
      }
    )
  end

  it 'raises an error if there is no channel and data information' do
    expect {
      ws.publish(foo: 'foo', bar: 'bar')
    }.to raise_error(ArgumentError)
  end
end