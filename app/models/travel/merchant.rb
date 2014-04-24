class Travel::Merchant < ActiveRecord::Base
  enum entity: %i[individual enterprise institution organization agent]
  enum status: %i[applied approved vetoed forbidden]

  belongs_to :continent
  belongs_to :country
  belongs_to :city
  belongs_to :phone_country, class_name: Travel::Country
  belongs_to :approved_by, class_name: Admin::User
  belongs_to :vetoed_by, class_name: Admin::User
  belongs_to :forbidden_by, class_name: Admin::User
  has_many :products
  has_many :journeys
  has_many :inventories

  # validates :phone_number, format: { with: /\A[\d-]+\Z/ }
  # validates :email, format: { with: /\A.+@.+\Z/ }
  # validates :qq, format: { with: /\A\d+\Z/ }
  validates :entity, :registration, :authorization, :name, :website, :principal_name, :principal_identifier, :principal_photo, :address, :latitude, :longitude, :phone_number, :email, :qq, :wechat, :skype, :logo, :description, presence: true
  validates :continent, :country, :city, :phone_country, existence: true

  cattr_accessor :admin_fields, :business_fields
  self.business_fields = %w[ entity registration authorization name website principal_name principal_identifier principal_photo continent_id country_id city_id address latitude longitude phone_country_id phone_number email qq wechat skype logo description ]
  self.admin_fields = self.business_fields + %w[]

  has_attached_file :registration, url: '/upload/travel/merchant/:id_partition/registration/:updated_at.:extension:style_extension'
  validates_attachment :registration_attachment, size: { in: 0..10.megabytes }
  has_attached_file :authorization, url: '/upload/travel/merchant/:id_partition/authorization/:updated_at.:extension:style_extension'
  validates_attachment :authorization_attachment, size: { in: 0..10.megabytes }
  has_attached_file :principal_photo, url: '/upload/travel/merchant/:id_partition/principal_photo/:updated_at.:extension:style_extension'
  validates_attachment :principal_photo_attachment, size: { in: 0..10.megabytes }, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }
  has_attached_file :logo, url: '/upload/travel/merchant/:id_partition/logo/:updated_at.:extension:style_extension'
  validates_attachment :logo_attachment, size: { in: 0..10.megabytes }, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }
end
