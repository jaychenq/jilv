class CreateAdminLogs < ActiveRecord::Migration
  def change
    create_table :admin_logs do |t|
      t.integer :user_id
      t.string :controller
      t.string :action
      t.integer :params_id
      t.datetime :created_at
    end
  end
end
