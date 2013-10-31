class Repository < ActiveRecord::Base
  belongs_to :user

  validates :name, :url, :user_id, presence: true
  validates_uniqueness_of :url

end
