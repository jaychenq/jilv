class AddIconToTravelLocations < ActiveRecord::Migration
  def change
    add_column :travel_locations, :icon, :string
    add_column :travel_locations, :icon_file_name, :string
    add_column :travel_locations, :icon_file_size, :integer
    add_column :travel_locations, :icon_content_type, :string
    add_column :travel_locations, :icon_updated_at, :datetime
    add_column :travel_locations, :icon_image_width, :integer
    add_column :travel_locations, :icon_image_height, :integer
    add_column :travel_locations, :background, :string
    add_column :travel_locations, :background_file_name, :string
    add_column :travel_locations, :background_file_size, :integer
    add_column :travel_locations, :background_content_type, :string
    add_column :travel_locations, :background_updated_at, :datetime
    add_column :travel_locations, :background_image_width, :integer
    add_column :travel_locations, :background_image_height, :integer
  end
end
