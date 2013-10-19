require 'spec_helper'

describe RunTestsWorker do
  it 'enqueues a job' do
    expect{
      RunTestsWorker.perform_async(1)
    }.to change(RunTestsWorker.jobs, :size).by(1)
  end
end
