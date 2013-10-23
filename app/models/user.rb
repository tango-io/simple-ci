require 'open-uri'
require 'json'
class User < ActiveRecord::Base

  def self.create_from_omniauth auth
    create! do |user|
      user.uid      = auth['uid']
      user.provider = auth['provider']
      user.name     = auth['info']['name']
      user.nickname = auth['info']['nickname']
    end
  end

  def public_repositories
    repos = JSON.parse(open("https://api.github.com/users/#{nickname}/repos").read)
    repos.map do |repo|
      { name: repo['name'] }
    end
  end

end
