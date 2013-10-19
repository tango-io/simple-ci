class JobsController < ApplicationController
  before_filter :set_session_id

  expose(:job, attributes: :job_params)

  #
  # Should receive by parameters the following
  #
  # params[:job] = {
  #   github_url: 'github_url'
  #   script: 'script'
  #
  # }
  #

  def create
    respond_to  do |format|
      if job.save
        format.json { render json: { message: 'Successfully enqueued test' }, status: :ok }
      else
        format.json { render json: { message: 'Something went wrong' }, status: :unprocessable_entity }
      end
    end
  end

  private
    def job_params
      params.require(:job).permit(:github_url, :session_id, :script)
    end

    def set_session_id
      params[:job].merge!(session_id: session[:user][:id])
    end
end
