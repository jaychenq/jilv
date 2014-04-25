class AddMerchantIdToTravelJourneys < ActiveRecord::Migration
  def change
    add_column :travel_journeys, :merchant_id, :integer
    add_index :travel_journeys, :merchant_id
  end
end
