class UsersController < ApplicationController

  def dashboard
    @repos = current_user.public_repositories
  end

end
