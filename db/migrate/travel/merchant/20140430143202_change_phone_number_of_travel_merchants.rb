class ChangePhoneNumberOfTravelMerchants < ActiveRecord::Migration
  def change
    change_column :travel_merchants, :phone_number, :string
  end
end
