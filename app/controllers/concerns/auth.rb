require 'active_support/concern'

module Auth
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
  end

  private
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def authenticate_user!
      unless current_user
        redirect_to root_path
        flash[:alert] = "Access dennied"
      end
    end

    def user_signed_in?
      defined? @current_user
    end
end
