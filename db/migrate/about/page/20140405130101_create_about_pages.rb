class CreateAboutPages < ActiveRecord::Migration
  def change
    create_table :about_pages do |t|
      t.string :name
      t.integer :position
      t.string :title
      t.string :keywords
      t.string :description
      t.text :body
      t.integer :template
      t.text :data
      t.integer :creator_id
      t.integer :updater_id
      t.boolean :published, null: false, default: false
      t.boolean :active, null: false, default: true
      t.integer :lock_version, null: false, default: 0

      t.timestamps
    end

    add_index :about_pages, :position
  end
end
