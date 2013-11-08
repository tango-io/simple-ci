class AddHookIdToRepository < ActiveRecord::Migration
  def change
    add_column :repositories, :hook_id, :string
  end
end
