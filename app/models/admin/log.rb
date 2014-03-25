class Admin::Log < ActiveRecord::Base
  belongs_to :user, class_name: Admin::User
end
