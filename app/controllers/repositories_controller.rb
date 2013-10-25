class RepositoriesController < ApplicationController
  expose(:repository)
  expose(:repositores){ current_user.repositories }

  def create
    respond_to do |format|
      if create_repositories(repositories_params)
        redirect_to dashboard_index_path
      else
        flash[:alert] = 'Something went wrong'
      end
    end
  end

  def destroy
  end

  def repositories_params
    params.require(:repositores).permit(repository: [ :name, :url, :activated, :user_id ])
  end

end
