class CreateTravelParameters < ActiveRecord::Migration
  def change
    create_table :travel_parameters do |t|
      t.integer :product_id
      t.integer :attribute_id
      t.string :option
      t.boolean :active, null: false, default: true
      t.integer :lock_version, null: false, default: 0
    end

    add_index :travel_parameters, :product_id
    add_index :travel_parameters, :attribute_id
  end
end
