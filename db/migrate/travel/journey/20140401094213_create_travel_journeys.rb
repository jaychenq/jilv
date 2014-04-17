class CreateTravelJourneys < ActiveRecord::Migration
  def change
    create_table :travel_journeys do |t|
      t.integer :product_id
      t.string :name
      t.integer :sequence
      t.integer :market_price
      t.integer :adult_price
      t.integer :kid_price
      t.integer :people_quota
      t.date :started_on
      t.date :ended_on
      t.integer :duration
      t.string :start_hour
      t.integer :early_booking
      t.boolean :pick_up, null: false, default: false
      t.boolean :with_food, null: false, default: false
      t.text :introduction
      t.text :fee_description
      t.text :refund_policy
      t.text :route
      t.text :tips
      t.boolean :active, null: false, default: true
      t.boolean :published, null: false, default: false
      t.integer :lock_version, null: false, default: 0
    end

    add_index :travel_journeys, :product_id
  end
end
