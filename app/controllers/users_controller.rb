class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :restricted_access!
  expose(:repos) { current_user.public_repositories }
  expose(:user)

  private

  def restricted_access!
    unless user.id == current_user.id
      redirect_to :root
      flash[:alert] = 'Restricted access'
    end
  end
end
