class Account::User < ActiveRecord::Base
  has_secure_password
  
  has_many :sessions
  
  attr_accessor :terms_of_service
  
  enum gender: %w[male female]
  
  validates :name, presence: true
  validates :email, uniqueness: true, format: { with: /\A[\w\.]+@[\w\.]+\Z/ }#, if: -> { email }
  validates :password, length: { in: 6..255 }, if: -> { password }
  validates :terms_of_service, acceptance: true
end