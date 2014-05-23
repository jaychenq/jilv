class CreateTravelBookings < ActiveRecord::Migration
  def change
    create_table :travel_bookings do |t|
      t.integer :status
      t.integer :user_id
      t.integer :merchant_id
      t.integer :product_id
      t.integer :journey_id
      t.date :started_on
      t.integer :adult_number
      t.integer :child_number
      t.integer :total_price
      t.string :name
      t.string :phone
      t.string :country
      t.string :state
      t.string :city
      t.string :address
      t.string :postcode
      t.string :payment_platform
      t.string :payment_identifier
      t.boolean :active, null: false, default: true
      t.integer :lock_version, null: false, default: 0

      t.timestamps
    end
  end
end
