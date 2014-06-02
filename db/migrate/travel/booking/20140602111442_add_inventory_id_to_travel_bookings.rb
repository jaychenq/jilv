class AddInventoryIdToTravelBookings < ActiveRecord::Migration
  def change
    add_column :travel_bookings, :inventory_id, :integer
    add_index :travel_bookings, :inventory_id
  end
end
