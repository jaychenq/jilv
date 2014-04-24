class AddTimestampsToTravelMerchants < ActiveRecord::Migration
  def change
    add_timestamps :travel_merchants
  end
end
