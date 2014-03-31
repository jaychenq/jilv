class AddPhoneCodeToTravelCountries < ActiveRecord::Migration
  def change
    add_column :travel_countries, :phone_code, :integer
  end
end
