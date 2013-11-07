require "net/http"
require "uri"
class Repository < ActiveRecord::Base
  belongs_to :user
  before_create :subscribe_hooks
  before_destroy :unsubscribe_hooks

  validates :name, :url, :user_id, presence: true
  validates_uniqueness_of :url

  private

  def self.hook_options
    {
      name:    'web',
      active:  true,
      events:  [
        'push',
        'pull_request',
        'issues'
      ],
      config: {
        url: 'http://simple-ci.r13.railsrumble.com/hooks/github.json',
        content_type: 'application/json'
      }
    }.to_json
  end

  def api_domain req
    uri = URI.parse('https://api.github.com')
    http =  Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.request(req)
  end

  def hooks_url
    "/repos/#{user.nickname}/#{name}/hooks"
  end

  def subscribe_hooks
    url = hooks_url+"?access_token=#{user.github_token}"
    req = Net::HTTP::Post.new(url)
    req['Content-Type'] = 'application/json'
    req.body = Repository.hook_options
    response = api_domain(req)
    response.code == '201' ? self.hook_id = JSON.parse(response.body)['id'] : false
  end

  def unsubscribe_hooks
    url= hooks_url+"/#{hook_id}?access_token=#{user.github_token}"
    req = Net::HTTP::Delete.new(url)
    response = api_domain(req)
    response.code == '204'
  end

end
