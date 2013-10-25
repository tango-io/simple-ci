class ApplicationController < ActionController::Base
  include Auth

  protect_from_forgery with: :exception

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end
end
