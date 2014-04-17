class Travel::Journey < ActiveRecord::Base
  belongs_to :product

  default_scope { where(active: true) }

  validates :sequence, :market_price, :adult_price, :kid_price, :people_quota, :duration, numericality: { only_integer: true }, allow_nil: true

  cattr_accessor :admin_fields, :business_fields
  self.admin_fields = %w[]
  self.business_fields = %w[ product_id name sequence market_price adult_price kid_price people_quota started_on ended_on duration start_hour early_booking pick_up with_food introduction fee_description refund_policy route tips published ]
end
