class Job < ActiveRecord::Base
  validates :session_id, :github_url, presence: true
  after_create :trigger_job
  serialize :script, Array

  def trigger_job
    RunTestsWorker.perform_async(self.id)
    publish(
      message: "Started job #{self.id}"
    )
  end

  def publish(data)
    Pusher.trigger(self.session_id, 'event', data)
  end

  def shell_script
    string =<<-BASH
#!bin/bash
mkdir #{self.session_id}
cd #{self.session_id}
#{self.script.join("\n")}
cd ~/
rm -rf #{self.session_id}
    BASH
    string
  end

end
