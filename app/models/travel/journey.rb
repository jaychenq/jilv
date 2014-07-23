class Travel::Journey < ActiveRecord::Base
  belongs_to :product
  belongs_to :merchant
  has_many :inventories

  default_scope { where(active: true) }

  validates :product_id, existence: true
  validates :name, :fee_description, :refund_policy, presence: true
  
  cattr_accessor :admin_fields, :business_fields
  self.business_fields = %w[ product_id name sequence market_price adult_price child_price people_quota started_on ended_on start_time duration_time early_booking pick_up with_food introduction fee_description child_level refund_policy other_description route tips published ]
  self.admin_fields = self.business_fields + %w[]
  
  before_validation do
    self.merchant_id = self.product.merchant.id
    true
  end
end
