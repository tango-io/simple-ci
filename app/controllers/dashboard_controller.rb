class DashboardController < ApplicationController
  before_filter :authenticate_user!

  expose(:user) { current_user }
  expose(:github_repos) { current_user.public_repositories }
  expose(:local_repos) { current_user.repositories }
end
