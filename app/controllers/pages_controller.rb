class PagesController < ApplicationController

  def index
  end

  def verify_gemfile
    @gemfile = Github.new(params[:repository])

    respond_to do |format|
      if @gemfile.is_valid?
        format.json { render json: { script: @gemfile.script } }
      else
        format.json {render json: {message: 'invalid repository'}, status: :unprocessable_entity }
      end
    end
  end

end
