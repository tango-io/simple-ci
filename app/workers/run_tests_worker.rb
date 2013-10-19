class RunTestsWorker
  include Sidekiq::Worker

  def perform(id)
    job = Job.find(id)
    # TODO add vagrant stuff
  end

end
