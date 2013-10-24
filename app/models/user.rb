require 'open-uri'

class User < ActiveRecord::Base

  validates :name, :uid, :provider, :nickname, presence: true

  validates :uid, :nickname, uniqueness: true

  validates_inclusion_of :provider, in: %w(github)

  def self.build_from_omniauth auth
    new(
      uid:      auth['uid'],
      provider: auth['provider'],
      name:     auth['info']['name'],
      nickname: auth['info']['nickname']
    )
  end

  def public_repositories
    repos = open("https://api.github.com/users/#{nickname}/repos").read
    repos = JSON.parse(repos)
    repos.map { |repo| { name: repo['name'] } }
  end

end
