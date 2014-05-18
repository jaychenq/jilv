class Travel::Favorite < ActiveRecord::Base
  belongs_to :user, class_name: Account::User
  belongs_to :product
  
  default_scope { where active: true }
end
