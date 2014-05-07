class AddFirstNameToTravelMerchants < ActiveRecord::Migration
  def change
    add_column :travel_merchants, :first_name, :string
    add_column :travel_merchants, :last_name, :string
    add_column :travel_merchants, :gender, :integer
    add_column :travel_merchants, :company, :string
    add_column :travel_merchants, :identification, :string
    add_column :travel_merchants, :identification_file_name, :string
    add_column :travel_merchants, :identification_file_size, :integer
    add_column :travel_merchants, :identification_content_type, :string
    add_column :travel_merchants, :identification_updated_at, :datetime
    add_column :travel_merchants, :lisense, :string
    add_column :travel_merchants, :lisense_file_name, :string
    add_column :travel_merchants, :lisense_file_size, :integer
    add_column :travel_merchants, :lisense_content_type, :string
    add_column :travel_merchants, :lisense_updated_at, :datetime
  end
end
