class AddLandscapeToTravelCountries < ActiveRecord::Migration
  def change
    add_column :travel_countries, :landscape, :string
    add_column :travel_countries, :landscape_file_name, :string
    add_column :travel_countries, :landscape_file_size, :integer
    add_column :travel_countries, :landscape_content_type, :string
    add_column :travel_countries, :landscape_updated_at, :datetime
    add_column :travel_countries, :landscape_image_width, :integer
    add_column :travel_countries, :landscape_image_height, :integer
  end
end
