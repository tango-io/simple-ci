require 'digest/sha1'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :session

  private

  def session
    session[:user] ||= {
      id: Digest::SHA1.hexdigest(request.remote_ip),
      expires: 1.day
    }
  end

end
