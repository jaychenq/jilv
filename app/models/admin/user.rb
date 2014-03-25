class Admin::User < ActiveRecord::Base
  belongs_to :account_user, class_name: ::Account::User, foreign_key: 'id'
  belongs_to :creator, class_name: self
  belongs_to :updater, class_name: self
  
  delegate :name, to: :account_user, allow_nil: true
  
  validates :creator, existence: true, allow_nil: true
  validates :updater, existence: true, allow_nil: true
end
