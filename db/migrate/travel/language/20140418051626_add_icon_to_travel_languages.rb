class AddIconToTravelLanguages < ActiveRecord::Migration
  def change
    add_column :travel_languages, :icon, :string
    add_column :travel_languages, :icon_file_name, :string
    add_column :travel_languages, :icon_file_size, :integer
    add_column :travel_languages, :icon_content_type, :string
    add_column :travel_languages, :icon_updated_at, :datetime
    add_column :travel_languages, :icon_image_width, :integer
    add_column :travel_languages, :icon_image_height, :integer
  end
end
