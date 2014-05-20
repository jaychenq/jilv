class Travel::Journey < ActiveRecord::Base
  belongs_to :product
  belongs_to :merchant
  has_many :inventories

  default_scope { where(active: true) }

  validates :product_id, existence: true
  validates :name, :introduction, :fee_description, :refund_policy, presence: true # , :started_on, :ended_on
  validates :people_quota, :market_price, :adult_price, :child_price, numericality: { only_integer: true } #, :sequence, :duration, :start_hour, :early_booking

  cattr_accessor :admin_fields, :business_fields
  self.business_fields = %w[ product_id name sequence market_price adult_price child_price people_quota started_on ended_on duration start_hour early_booking pick_up with_food introduction fee_description refund_policy route tips published ]
  self.admin_fields = self.business_fields + %w[]
  
  before_validation do
    self.merchant_id = self.product.merchant.id
    true
  end
end
