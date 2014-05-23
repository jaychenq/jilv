class Travel::Booking < ActiveRecord::Base
  belongs_to :user, class_name: Account::User
  belongs_to :merchant
  belongs_to :product
  belongs_to :journey

  validates :user, :merchant, :product, :journey, existence: true
  validates :adult_number, :child_number, :total_price, numericality: { only_integer: true }
  validates :started_on, :name, :phone, :country, :state, :city, :address, :postcode, presence: true
  
  default_scope { where(active: true) }
  
  cattr_accessor :admin_fields
  self.admin_fields = %w[]
  
  before_validation do
    self.product_id = self.journey.product.id
    self.merchant_id = self.product.merchant.id
    self.total_price = self.adult_number.to_i * self.journey.adult_price.to_i + self.child_number.to_i * self.journey.child_price.to_i
    true
  end
end
