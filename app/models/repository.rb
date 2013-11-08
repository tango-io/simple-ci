class Repository < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :name, :url, presence: true
  validates_uniqueness_of :url

end
