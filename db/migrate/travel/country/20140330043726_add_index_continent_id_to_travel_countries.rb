class AddIndexContinentIdToTravelCountries < ActiveRecord::Migration
  def change
    add_index :travel_countries, :continent_id
  end
end
