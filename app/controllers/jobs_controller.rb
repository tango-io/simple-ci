class JobsController < ApplicationController
  def create
    RunTestsWorker.perform_async(session[:user])
    render json: { message: 'Successfully enqueued test' }, status: :ok
  end
end
