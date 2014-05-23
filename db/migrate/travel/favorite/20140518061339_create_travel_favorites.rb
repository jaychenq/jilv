class CreateTravelFavorites < ActiveRecord::Migration
  def change
    create_table :travel_favorites do |t|
      t.integer :user_id
      t.integer :product_id
      t.boolean :active, null: false, default: true
      t.integer :lock_version, null: false, default: 0

      t.timestamps
    end
  end
end
