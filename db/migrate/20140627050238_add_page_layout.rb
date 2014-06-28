class AddPageLayout < ActiveRecord::Migration
  def up
  	add_column :about_pages,:layout,:string
  end
  def down
  	remove_column :about_pages,:layout,:string
  end
end
