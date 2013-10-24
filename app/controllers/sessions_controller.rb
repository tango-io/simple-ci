class SessionsController < ApplicationController
  expose(:user) { User.build_from_omniauth(request.env['omniauth.auth']) }

  def create
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_index_path, :notice => "Signed in!"
    else
      session[:user_id] = nil
      redirect_to :root, :notice => "Signed out!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root, :notice => "Signed out!"
  end

end
