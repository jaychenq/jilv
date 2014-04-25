class AddIconToTravelCountries < ActiveRecord::Migration
  def change
    add_column :travel_countries, :icon, :string
    add_column :travel_countries, :icon_file_name, :string
    add_column :travel_countries, :icon_file_size, :integer
    add_column :travel_countries, :icon_content_type, :string
    add_column :travel_countries, :icon_updated_at, :datetime
    add_column :travel_countries, :icon_image_width, :integer
    add_column :travel_countries, :icon_image_height, :integer
    add_column :travel_countries, :background, :string
    add_column :travel_countries, :background_file_name, :string
    add_column :travel_countries, :background_file_size, :integer
    add_column :travel_countries, :background_content_type, :string
    add_column :travel_countries, :background_updated_at, :datetime
    add_column :travel_countries, :background_image_width, :integer
    add_column :travel_countries, :background_image_height, :integer
  end
end
