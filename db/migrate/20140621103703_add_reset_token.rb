class AddResetToken < ActiveRecord::Migration
  def up
	   add_column :account_users,:reset_token,:string
	   add_column :account_users,:reset_at,:datetime
  end

  def down
  	 remove_column :account_users,:reset_token
  	 remove_column :account_users,:reset_at
  end
end
