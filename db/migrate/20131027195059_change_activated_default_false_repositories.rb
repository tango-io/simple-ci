class ChangeActivatedDefaultFalseRepositories < ActiveRecord::Migration
  def change
    change_column :repositories, :activated, :boolean, default: false
  end
end
