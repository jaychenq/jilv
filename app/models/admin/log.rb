class Admin::Log < ActiveRecord::Base
  belongs_to :user, class_name: Admin::User
  
  validates :user, existence: true, allow_nil: true
end
