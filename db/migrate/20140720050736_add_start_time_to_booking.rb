class AddStartTimeToBooking < ActiveRecord::Migration
  def up
  	add_column :travel_bookings,:start_time,:string
  end
  def down
  	remove_column :travel_bookings,:start_time
  end
end
