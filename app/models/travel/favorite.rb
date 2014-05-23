class Travel::Favorite < ActiveRecord::Base
  belongs_to :user, class_name: Account::User
  belongs_to :product

  validates :user, :product, existence: true

  default_scope { where active: true }
  
  cattr_accessor :admin_fields
  self.admin_fields = %w[ user_id product_id ]
end
