class AddMktPricesToTravelInventory < ActiveRecord::Migration
  def change
  	add_column :travel_inventories, :adult_mkt_price, :integer
    add_column :travel_inventories, :child_mkt_price, :integer
  end
end
