class AddConfirmationToTravelBookings < ActiveRecord::Migration
  def change
    add_column :travel_bookings, :confirmation, :boolean
  end
end
