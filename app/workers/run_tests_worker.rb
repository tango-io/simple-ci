class RunTestsWorker
  include Sidekiq::Worker

  def perform(id)
    puts "holi"
  end

end
