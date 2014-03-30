class AddColumnCategoryIdToTravelAttributes < ActiveRecord::Migration
  def change
    add_column :travel_attributes, :category_id, :integer
    add_index :travel_attributes, :category_id
  end
end
