class AddIndexCityIdToTravelLocations < ActiveRecord::Migration
  def change
    add_index :travel_locations, :city_id
  end
end
