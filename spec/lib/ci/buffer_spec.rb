require 'spec_helper'

describe Ci::Buffer, 'initialize' do

  let(:job) { Fabricate :job }

  it 'receives the job' do
    Ci::Buffer.new(job.session_id)
  end

  it 'returns an error if there\'s no job given' do
    expect { Ci::Buffer.new }.to raise_error
  end

end

describe Ci::Buffer, 'update buffer' do

  let!(:job)   { Fabricate :job }
  let(:buffer) { Ci::Buffer.new(job.session_id) }

  before do
    Ci::WebSocket.any_instance.stub(:publish).and_return(true)
  end

  it 'updates the log_output from the job with the buffer of the ssh connection' do
    text = Faker::Lorem.sentence
    buffer << text
    expect(buffer.stream).to eq(text)
  end
end
