class AddTipsToTravelProducts < ActiveRecord::Migration
  def change
    add_column :travel_products, :activity_time, :string
    add_column :travel_products, :colony, :string
    add_column :travel_products, :early_booking, :integer
    add_column :travel_products, :arrival, :text
    add_column :travel_products, :tips, :text
  end
end
