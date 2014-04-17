class CreateTravelProductsPhotos < ActiveRecord::Migration
  def change
    create_table :travel_products_photos do |t|
      t.integer :product_id
      t.integer :sequence
      t.string :file
      t.string :file_file_name
      t.integer :file_file_size
      t.string :file_content_type
      t.datetime :file_updated_at
      t.integer :file_image_width
      t.integer :file_image_height
      t.boolean :active, null: false, default: true
      t.integer :lock_version, null: false, default: 0
    end

    add_index :travel_products_photos, :product_id
  end
end
