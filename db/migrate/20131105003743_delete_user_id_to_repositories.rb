class DeleteUserIdToRepositories < ActiveRecord::Migration
  def change
    remove_column :repositories, :user_id
  end
end
