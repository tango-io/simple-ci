require 'httparty'
class Repository < ActiveRecord::Base
  belongs_to :user
  before_create :subscribe_hooks
  before_destroy :unsubscribe_hooks

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

  private

  def hooks_url
    "https://api.github.com/repos/#{user.nickname}/#{name}/hooks"
  end

  def subscribe_hooks
    url= hooks_url+"?access_token=#{user.github_token}"
    response = HTTParty.post(url, body: HOOK_OPTIONS)
    if response['id'].present?
      self.hook_id = response['id']
    else
      false
    end
  end

  def unsubscribe_hooks
    url= hooks_url+"/#{hook_id}?access_token=#{user.github_token}"
    response = HTTParty.delete(url)
    false unless response.nil?
  end

end
