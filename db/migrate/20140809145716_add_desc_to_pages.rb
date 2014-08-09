class AddDescToPages < ActiveRecord::Migration
  def up
  	add_column :about_pages,:desc,:text
  end
  def down
  	remove_column :about_pages,:desc
  end
end
