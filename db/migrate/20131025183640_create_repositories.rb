class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string  :uid
      t.string  :name
      t.string  :url
      t.integer :user_id
      t.boolean :activated, default: false

      t.timestamps
    end
  end
end
