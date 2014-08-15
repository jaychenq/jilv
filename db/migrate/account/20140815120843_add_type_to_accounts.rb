class AddTypeToAccounts < ActiveRecord::Migration
  def up
	   add_column :account_users,:account_type,:integer
  end

  def down
  	 remove_column :account_users,:account_type
  end
end
