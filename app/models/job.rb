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
    ws = Ci::WebSocket.new
    ws.publish(
      channel: self.session_id,
      data: {
        log: "started tests for #{self.session_id}"
      }
    )
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
