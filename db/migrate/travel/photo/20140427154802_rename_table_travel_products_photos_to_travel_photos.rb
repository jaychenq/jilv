class RenameTableTravelProductsPhotosToTravelPhotos < ActiveRecord::Migration
  def change
    rename_table :travel_products_photos, :travel_photos
  end
end
