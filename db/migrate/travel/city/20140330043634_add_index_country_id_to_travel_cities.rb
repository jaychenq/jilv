class AddIndexCountryIdToTravelCities < ActiveRecord::Migration
  def change
    add_index :travel_cities, :country_id
  end
end
