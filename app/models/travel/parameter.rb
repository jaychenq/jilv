class Travel::Parameter < ActiveRecord::Base
  belongs_to :product
  belongs_to :_attribute, class_name: Travel::Attribute, foreign_key: 'attribute_id'

  # validates :_attribute, existence: true

  default_scope { where(active: true) }

  cattr_accessor :admin_fields, :business_fields
  self.business_fields = %w[ product_id attribute_id option ]
  self.admin_fields = self.business_fields + %w[]
end
