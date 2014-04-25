class AddLandscapeToTravelCategories < ActiveRecord::Migration
  def change
    add_column :travel_categories, :landscape, :string
    add_column :travel_categories, :landscape_file_name, :string
    add_column :travel_categories, :landscape_file_size, :integer
    add_column :travel_categories, :landscape_content_type, :string
    add_column :travel_categories, :landscape_updated_at, :datetime
    add_column :travel_categories, :landscape_image_width, :integer
    add_column :travel_categories, :landscape_image_height, :integer
  end
end
