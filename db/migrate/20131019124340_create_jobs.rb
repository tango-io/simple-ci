class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.text   :session_id
      t.string :github_url
      t.text   :log_output
      t.timestamps
    end
  end
end
