class ChangeChildPriceOfTravelJourneys < ActiveRecord::Migration
  def change
    rename_column :travel_journeys, :kid_price, :child_price
  end
end
