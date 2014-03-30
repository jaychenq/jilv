class AddIndexParentIdToTravelCategories < ActiveRecord::Migration
  def change
    add_index :travel_categories, :parent_id
  end
end
