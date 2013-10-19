require 'sidekiq_status'

class Api::WorkersController < ApplicationController
  skip_before_filter :set_session

  def index
    render json: ::SidekiqStatus.new
  end

end
