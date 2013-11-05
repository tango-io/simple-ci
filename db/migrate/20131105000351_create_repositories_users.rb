class CreateRepositoriesUsers < ActiveRecord::Migration
  def change
    create_table :repositories_users, id: false do |t|
      t.references :repository
      t.references :user
    end

    add_index :repositories_users, :repository_id
    add_index :repositories_users, :user_id
  end
end
