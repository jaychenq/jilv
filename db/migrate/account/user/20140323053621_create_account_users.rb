class CreateAccountUsers < ActiveRecord::Migration
  def change
    create_table :account_users do |t|
      t.string :name
      t.integer :gender
      t.string :avatar
      t.string :email
      t.string :password
      t.string :password_digest
      t.string :email_activation_code
      t.datetime :email_activated_at
      t.boolean :forbidden, null: false, default: false
      t.integer :lock_version, null: false, default: 0

      t.timestamps
    end
    
    add_index :account_users, :email
  end
end
