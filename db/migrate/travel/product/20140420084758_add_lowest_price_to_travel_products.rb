class AddLowestPriceToTravelProducts < ActiveRecord::Migration
  def change
    add_column :travel_products, :lowest_price, :integer
  end
end
