class RepositoriesController < ApplicationController
  expose(:repository, attributes: :repository_params, finder: :find_by_uid)
  expose(:repositories){ current_user.repositories }

  def create
    current_user.add_repository(repository)
    respond_to do |format|
      if repository.stored?
        format.json {render status: :ok, json: { message: 'Successfully added repository' } }
      else
        format.json {render status: :unproccesable_entity, json: { message: 'Can not add the repository' } }
      end
    end
  end

  def destroy
    respond_to do |format|
      if repository.delete_user(current_user)
        format.json {render status: :ok, json: { message: 'Successfully deleted repository' } }
      else
        format.json {render status: :unproccesable_entity, json: { message: 'Can not delete the repository' } }
      end
    end
  end

  private

  def repository_params
    params.require(:repository).permit( :name, :url, :activated, :user_id, :uid )
  end

end
