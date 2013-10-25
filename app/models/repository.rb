class Repository < ActiveRecord::Base
  belongs_to :user

  validates :name, :url, :user_id, presence: true
  validates_uniqueness_of :url, { scope: :user_id }

  def self.create_repositories repos
    Repository.create(repos)
  end

end
