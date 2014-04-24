class CreateTravelInventories < ActiveRecord::Migration
  def change
    create_table :travel_inventories do |t|
      t.integer :journey_id
      t.date :started_on
      t.integer :amount
      t.integer :remainder
      t.integer :adult_price
      t.integer :child_price
      t.boolean :active, null: false, default: true
      t.integer :lock_version, null: false, default: 0

      t.timestamps
    end

    add_index :travel_inventories, [:journey_id, :started_on]
  end
end
