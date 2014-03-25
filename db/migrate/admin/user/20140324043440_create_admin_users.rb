class CreateAdminUsers < ActiveRecord::Migration
  def change
    create_table :admin_users do |t|
      t.integer :creator_id
      t.integer :updater_id
      t.integer :lock_version, null: false, default: 0

      t.timestamps
    end
  end
end
