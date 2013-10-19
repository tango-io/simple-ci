class Job < ActiveRecord::Base
  validates :session_id, :github_url, presence: true
end
