class AddDescToPages < ActiveRecord::Migration
  def up
  	add_column :about_pages,:desc,:string
  end
  def down
  	remove_column :about_pages,:desc,:string
  end
end
