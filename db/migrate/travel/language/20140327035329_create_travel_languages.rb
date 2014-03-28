class CreateTravelLanguages < ActiveRecord::Migration
  def change
    create_table :travel_languages do |t|
      t.string :locale
      t.string :name
      t.text :description
      t.integer :sequence
      t.integer :creator_id
      t.integer :updater_id
      t.boolean :active, null: false, default: true
      t.boolean :published, null: false, default: false
      t.integer :lock_version, null: false, default: 0

      t.timestamps
    end
  end
end
