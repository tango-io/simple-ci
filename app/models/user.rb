require 'open-uri'

class User < ActiveRecord::Base
  has_and_belongs_to_many :repositories

  validates :name, :uid, :provider, :nickname, presence: true
  validates :uid, :nickname, uniqueness: true
  validates_inclusion_of :provider, in: %w(github)

  def self.build_from_omniauth auth
    find_or_initialize_by(
      uid:      auth['uid'],
      provider: auth['provider'],
      name:     auth['info']['name'],
      nickname: auth['info']['nickname']
    )
  end

  def public_repositories
    repos = open("https://api.github.com/users/#{nickname}/repos").read
    repos = JSON.parse(repos)
    repos.map do |repo|
      Repository.find_or_initialize_by(
        uid:  repo['id'],
        name: repo['name'],
        url:  repo['url']
      )
    end
  end

  def add_repository(repository)
    self.repositories.push(repository)
  end
end
