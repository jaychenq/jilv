class AddLandscapeToTravelContinents < ActiveRecord::Migration
  def change
    add_column :travel_continents, :landscape, :string
    add_column :travel_continents, :landscape_file_name, :string
    add_column :travel_continents, :landscape_file_size, :integer
    add_column :travel_continents, :landscape_content_type, :string
    add_column :travel_continents, :landscape_updated_at, :datetime
    add_column :travel_continents, :landscape_image_width, :integer
    add_column :travel_continents, :landscape_image_height, :integer
  end
end
