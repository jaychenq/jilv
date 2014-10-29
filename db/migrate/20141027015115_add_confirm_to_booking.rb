class AddConfirmToBooking < ActiveRecord::Migration
  def up
  	add_column :travel_bookings,:do_confirm,:string
  	add_column :travel_bookings,:confirm_text,:string
  end
  def down
  	remove_column :travel_bookings,:do_confirm
  	remove_column :travel_bookings,:confirm_text
  end
end
