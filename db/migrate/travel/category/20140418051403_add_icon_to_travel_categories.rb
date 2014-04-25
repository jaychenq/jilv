class AddIconToTravelCategories < ActiveRecord::Migration
  def change
    add_column :travel_categories, :icon, :string
    add_column :travel_categories, :icon_file_name, :string
    add_column :travel_categories, :icon_file_size, :integer
    add_column :travel_categories, :icon_content_type, :string
    add_column :travel_categories, :icon_updated_at, :datetime
    add_column :travel_categories, :icon_image_width, :integer
    add_column :travel_categories, :icon_image_height, :integer
    add_column :travel_categories, :background, :string
    add_column :travel_categories, :background_file_name, :string
    add_column :travel_categories, :background_file_size, :integer
    add_column :travel_categories, :background_content_type, :string
    add_column :travel_categories, :background_updated_at, :datetime
    add_column :travel_categories, :background_image_width, :integer
    add_column :travel_categories, :background_image_height, :integer
  end
end
