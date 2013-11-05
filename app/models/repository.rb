class Repository < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :name, :url, presence: true
  validates_uniqueness_of :url

  def delete_user(user)
    @user = user
    remove_repository unless find_repository
    full_destroy
  end

  def stored?
    unless Repository.find_by_url(self.url).nil?
      true
    else
      self.save
    end
  end

  private

  def full_destroy
    self.destroy if find_repository
  end

  def remove_repository
    @user.repositories.delete(self)
  end

  def find_repository
    @user.repositories.find_by_url(self.url).nil?
  end
end
