class Job < ActiveRecord::Base
  validates :session_id, :github_url, presence: true
  after_create :trigger_job

  def trigger_job
    RunTestsWorker.perform_async(self.id)
    publish(
      message: "Started job #{self.id}"
    )
  end

  def publish(data)
    Pusher.trigger(self.session_id, 'event', data)
  end
end
