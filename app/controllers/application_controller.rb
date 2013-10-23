require 'digest/sha1'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    unless current_user
      redirect_to :root
      flash[:alert] = "Access dennied"
    end
  end

end
