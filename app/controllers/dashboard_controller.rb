class DashboardController < ApplicationController
  before_filter :authenticate_user!

  expose(:user) { current_user }
  expose(:repos) { current_user.public_repositories }

  def index
  end
end
