class AddMerchantIdToTravelInventories < ActiveRecord::Migration
  def change
    add_column :travel_inventories, :merchant_id, :integer
    add_column :travel_inventories, :product_id, :integer
    add_index :travel_inventories, :merchant_id
    add_index :travel_inventories, :product_id
  end
end
