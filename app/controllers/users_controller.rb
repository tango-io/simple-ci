class UsersController < ApplicationController
  before_filter :authenticate_user!
  expose(:repos) { current_user.public_repositories }
end
