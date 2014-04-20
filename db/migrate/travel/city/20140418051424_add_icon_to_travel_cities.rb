class AddIconToTravelCities < ActiveRecord::Migration
  def change
    add_column :travel_cities, :icon, :string
    add_column :travel_cities, :icon_file_name, :string
    add_column :travel_cities, :icon_file_size, :integer
    add_column :travel_cities, :icon_content_type, :string
    add_column :travel_cities, :icon_updated_at, :datetime
    add_column :travel_cities, :icon_image_width, :integer
    add_column :travel_cities, :icon_image_height, :integer
    add_column :travel_cities, :background, :string
    add_column :travel_cities, :background_file_name, :string
    add_column :travel_cities, :background_file_size, :integer
    add_column :travel_cities, :background_content_type, :string
    add_column :travel_cities, :background_updated_at, :datetime
    add_column :travel_cities, :background_image_width, :integer
    add_column :travel_cities, :background_image_height, :integer
  end
end
