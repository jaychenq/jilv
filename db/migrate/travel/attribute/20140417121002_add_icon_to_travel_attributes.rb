class AddIconToTravelAttributes < ActiveRecord::Migration
  def change
    add_column :travel_attributes, :icon, :string
    add_column :travel_attributes, :icon_file_name, :string
    add_column :travel_attributes, :icon_file_size, :integer
    add_column :travel_attributes, :icon_content_type, :string
    add_column :travel_attributes, :icon_updated_at, :datetime
    add_column :travel_attributes, :icon_image_width, :integer
    add_column :travel_attributes, :icon_image_height, :integer
  end
end
