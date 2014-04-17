class CreateTravelProducts < ActiveRecord::Migration
  def change
    create_table :travel_products do |t|
      t.string :name
      t.text :description
      t.integer :merchant_id
      t.integer :category_id
      t.integer :continent_id
      t.integer :country_id
      t.integer :city_id
      t.integer :location_id
      t.string :latitude
      t.string :longitude
      t.integer :cover_id
      t.date :started_on
      t.date :ended_on
      t.boolean :published, null: false, default: false
      t.boolean :active, null: false, default: true
      t.integer :lock_version, null: false, default: true
    end

    add_index :travel_products, :merchant_id
    add_index :travel_products, :category_id
    add_index :travel_products, :continent_id
    add_index :travel_products, :country_id
    add_index :travel_products, :city_id
    add_index :travel_products, :location_id
    add_index :travel_products, :started_on
    add_index :travel_products, :ended_on
  end
end
