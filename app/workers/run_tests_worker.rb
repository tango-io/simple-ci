class RunTestsWorker
  include Sidekiq::Worker

  def perform(id)
    # TODO Add logic for run the tests and comunicate with the websocket
  end

end
