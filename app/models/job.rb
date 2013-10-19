class Job < ActiveRecord::Base
  validates :session_id, :github_url, :log_output, presence: true
end
