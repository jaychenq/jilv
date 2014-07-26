class AddNickNameToAccountUser < ActiveRecord::Migration
  def up
  	add_column :account_users,:nick_name,:string
  end
  def down
  	remove_column :account_users,:nick_name
  end
end
