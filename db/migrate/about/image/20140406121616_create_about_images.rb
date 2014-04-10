class CreateAboutImages < ActiveRecord::Migration
  def change
    create_table :about_images do |t|
      t.integer :page_id
      t.string :name
      t.string :file
      t.string :file_file_name
      t.integer :file_file_size
      t.string :file_content_type
      t.datetime :file_updated_at
      t.integer :file_image_width
      t.integer :file_image_height
      t.integer :creator_id
      t.integer :updater_id
      t.boolean :active, null: false, default: true
      t.integer :lock_version, null: false, default: 0

      t.timestamps
    end

    add_index :about_images, :page_id
  end
end
