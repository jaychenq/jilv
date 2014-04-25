class AddPreservedNumberToTravelInventories < ActiveRecord::Migration
  def change
    add_column :travel_inventories, :preserved_number, :integer
    rename_column :travel_inventories, :amount, :total_number
    rename_column :travel_inventories, :remainder, :remained_number
  end
end
