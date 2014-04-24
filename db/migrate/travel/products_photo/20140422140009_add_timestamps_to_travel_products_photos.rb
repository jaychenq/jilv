class AddTimestampsToTravelProductsPhotos < ActiveRecord::Migration
  def change
    add_timestamps :travel_products_photos
  end
end
