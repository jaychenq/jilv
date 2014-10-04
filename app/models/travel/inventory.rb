class Travel::Inventory < ActiveRecord::Base
  belongs_to :journey
  belongs_to :product
  belongs_to :merchant
  has_many :bookings

  default_scope { where(active: true) }

  validates :journey, existence: true
  validates :started_on, presence: true
  validates :adult_price, :child_price, :total_number, :preserved_number, :remained_number, numericality: { only_integer: true }, allow_blank: true

  cattr_accessor :admin_fields, :business_fields
  self.business_fields = %w[ journey_id started_on adult_price child_price adult_mkt_price child_mkt_price total_number ]
  self.admin_fields = self.business_fields + %w[]
  
  before_validation do
    self.preserved_number ||= 0
    self.total_number = self.preserved_number if self.total_number.to_i < self.preserved_number.to_i
    self.remained_number = self.total_number.to_i - self.preserved_number.to_i
    self.product_id = self.journey.product.id
    self.merchant_id = self.journey.product.merchant.id
    true
  end
end
