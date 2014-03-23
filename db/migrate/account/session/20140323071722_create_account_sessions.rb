class CreateAccountSessions < ActiveRecord::Migration
  def change
    create_table :account_sessions do |t|
      t.integer :user_id
      t.datetime :expired_at
      t.string :ip_address
      t.string :user_agent
      t.string :referrer
      t.integer :lock_version, null: false, default: 0

      t.timestamps
    end
    
    add_index :account_sessions, :user_id
  end
end
