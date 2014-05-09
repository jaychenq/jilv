class Account::User < ActiveRecord::Base
  has_secure_password
  
  belongs_to :admin_user, class_name: Admin::User, foreign_key: 'id'
  belongs_to :merchant, class_name: Travel::Merchant, foreign_key: 'id'
  has_many :sessions
  
  attr_accessor :terms_of_service
  
  enum gender: %w[male female]
  
  validates :name, presence: true
  validates :email, uniqueness: true, format: { with: /\A.+@.+\Z/ }#, if: -> { email }
  validates :password, length: { in: 6..255 }, if: -> { password }
  validates :terms_of_service, acceptance: true
  
  has_attached_file :avatar, url: '/upload/account/user/:id_partition/avatar/:updated_at.:extension:style_extension', styles: { :'180' => '180x180#' }
  validates_attachment :avatar_attachment, size: { in: 0..10.megabytes }, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }
end
