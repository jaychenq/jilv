class AddLowestPriceToTravelJourneys < ActiveRecord::Migration
  def change
    add_column :travel_journeys, :lowest_price, :integer
  end
end
