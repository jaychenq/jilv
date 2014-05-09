class AddPublishedToTravelMerchants < ActiveRecord::Migration
  def change
    add_column :travel_merchants, :published, :boolean, null: false, default: false
  end
end
