class CreateTravelMerchants < ActiveRecord::Migration
  def change
    create_table :travel_merchants do |t|
      t.integer :status
      t.integer :entity
      t.string :registration
      t.string :registration_file_name
      t.integer :registration_file_size
      t.string :registration_content_type
      t.datetime :registration_updated_at
      t.string :authorization
      t.string :authorization_file_name
      t.integer :authorization_file_size
      t.string :authorization_content_type
      t.datetime :authorization_updated_at
      t.string :name
      t.string :website
      t.string :principal_name
      t.string :principal_identifier
      t.string :principal_photo
      t.string :principal_photo_file_name
      t.integer :principal_photo_file_size
      t.string :principal_photo_content_type
      t.datetime :principal_photo_updated_at
      t.integer :principal_photo_image_width
      t.integer :principal_photo_image_height
      t.integer :continent_id
      t.integer :country_id
      t.integer :city_id
      t.string :address
      t.string :latitude
      t.string :longitude
      t.integer :phone_country_id
      t.integer :phone_number
      t.string :email
      t.string :qq
      t.string :wechat
      t.string :skype
      t.string :logo
      t.string :logo_file_name
      t.integer :logo_file_size
      t.string :logo_content_type
      t.datetime :logo_updated_at
      t.integer :logo_image_width
      t.integer :logo_image_height
      t.text :description
      t.datetime :applied_at
      t.integer :approved_by_id
      t.datetime :approved_at
      t.integer :vetoed_by_id
      t.datetime :vetoed_at
      t.integer :forbidden_by_id
      t.datetime :forbidden_at
      t.integer :lock_version, null: false, default: 0
    end
    
    add_index :travel_merchants, :status
    add_index :travel_merchants, :entity
    add_index :travel_merchants, :continent_id
    add_index :travel_merchants, :country_id
    add_index :travel_merchants, :city_id
  end
end
