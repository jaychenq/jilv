class CreateTravelSpeakings < ActiveRecord::Migration
  def change
    create_table :travel_speakings do |t|
      t.integer :product_id
      t.integer :language_id
      t.boolean :active, null: false, default: true
      t.integer :lock_version, null: false, default: 0
    end

    add_index :travel_speakings, :product_id
    add_index :travel_speakings, :language_id
  end
end
