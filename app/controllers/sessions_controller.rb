class SessionsController < ApplicationController
  expose(:user) { User.build_from_omniauth(request.env['omniauth.auth']) }

  def create
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_index_path, notice: "Successfully signed in, welcome."
    else
      session[:user_id] = nil
      redirect_to :root, notice: "Could not sign in, please try again."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root, notice: "Successfully signed out."
  end

end
