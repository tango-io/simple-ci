require 'httparty'
class Repository < ActiveRecord::Base
  belongs_to :user
  after_create :suscribe_hooks

  validates :name, :url, :user_id, presence: true
  validates_uniqueness_of :url

  HOOK_OPTIONS = {
    name:    "web",
    active:  true,
    events:  [
      "push",
      "pull_request"
    ],
    config: {
      url: "http://simple-ci.r13.railsrumble.com/hooks/github.json",
      content_type: "application/json"
    }
  }.to_json

  def hooks_url
    "https://api.github.com/repos/#{user.nickname}/#{name}/events/"
  end

  def suscribe_hooks
    url = "https://api.github.com/repos/#{user.nickname}/#{name}/hooks"
    url+= "?access_token=#{user.github_token}"
    response = HTTParty.post(url, body: HOOK_OPTIONS)
    if response['id'].exists?
      update(hook_id: response['id'])
    else
      false
    end
  end

end
