class AddIconToTravelContinents < ActiveRecord::Migration
  def change
    add_column :travel_continents, :icon, :string
    add_column :travel_continents, :icon_file_name, :string
    add_column :travel_continents, :icon_file_size, :integer
    add_column :travel_continents, :icon_content_type, :string
    add_column :travel_continents, :icon_updated_at, :datetime
    add_column :travel_continents, :icon_image_width, :integer
    add_column :travel_continents, :icon_image_height, :integer
    add_column :travel_continents, :background, :string
    add_column :travel_continents, :background_file_name, :string
    add_column :travel_continents, :background_file_size, :integer
    add_column :travel_continents, :background_content_type, :string
    add_column :travel_continents, :background_updated_at, :datetime
    add_column :travel_continents, :background_image_width, :integer
    add_column :travel_continents, :background_image_height, :integer
  end
end
