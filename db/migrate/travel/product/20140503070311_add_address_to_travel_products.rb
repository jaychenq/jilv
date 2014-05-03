class AddAddressToTravelProducts < ActiveRecord::Migration
  def change
    add_column :travel_products, :address, :string
  end
end
