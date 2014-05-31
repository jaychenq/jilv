class AddHighlightToTravelProducts < ActiveRecord::Migration
  def change
    add_column :travel_products, :highlight, :text
  end
end
