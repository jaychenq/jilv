class AddCategory1IdToTravelProducts < ActiveRecord::Migration
  def change
    add_column :travel_products, :category1_id, :integer
    add_column :travel_products, :category2_id, :integer
    add_index :travel_products, :category1_id
    add_index :travel_products, :category2_id
  end
end
