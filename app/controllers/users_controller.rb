class UsersController < ApplicationController
  expose(:repos) { current_user.public_repositories }
end
