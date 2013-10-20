class Job < ActiveRecord::Base
  validates :session_id, :github_url, presence: true
  serialize :script, Array

  after_create :trigger_job

  def trigger_job
    RunTestsWorker.perform_async(self.id)
    publish(
      'job_started',
      message: "Started job #{self.id}"
    )
  end

  def publish(event_type, data)
    Pusher.trigger(self.session_id, event_type, data)
  end

  def shell_script
    string =<<-BASH
#!/bin/bash
mkdir #{self.session_id}
cd #{self.session_id}
#{self.script.join("\n")}
cd ~/
rm -rf #{self.session_id}*
    BASH
    string
  end

end
