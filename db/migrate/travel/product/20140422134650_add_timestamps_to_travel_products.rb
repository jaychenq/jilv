class AddTimestampsToTravelProducts < ActiveRecord::Migration
  def change
    add_timestamps :travel_products
  end
end
