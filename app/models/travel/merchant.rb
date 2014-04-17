class Travel::Merchant < ActiveRecord::Base
  enum entity: %i[individual enterprise institution organization agent]
  enum status: %i[applied approved vetoed forbidden]

  belongs_to :continent
  belongs_to :country
  belongs_to :city
  belongs_to :photo_country
  belongs_to :approved_by, class_name: Admin::User
  belongs_to :vetoed_by, class_name: Admin::User
  belongs_to :forbidden_by, class_name: Admin::User
  has_many :products

  validates :phone_number, format: { with: /\A[\d-]+\Z/ }, allow_blank: true
  validates :email, format: { with: /\A.+@.+\Z/ }, allow_blank: true
  validates :qq, format: { with: /\A\d+\Z/ }, allow_blank: true

  cattr_accessor :admin_fields, :business_fields
  self.admin_fields = %w[]
  self.business_fields = %w[ entity registration authorization name website principal_name principal_identifier principal_photo continent_id country_id city_id address latitude longitude phone_country_id phone_number email qq wechat skype logo description ]

  has_attached_file :registration, url: '/upload/travel/merchant/:id_partition/registration/:updated_at.:extension:style_extension'
  validates_attachment :registration_attachment, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }
  has_attached_file :authorization, url: '/upload/travel/merchant/:id_partition/authorization/:updated_at.:extension:style_extension'
  validates_attachment :authorization_attachment, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }
  has_attached_file :principal_photo, url: '/upload/travel/merchant/:id_partition/principal_photo/:updated_at.:extension:style_extension'
  validates_attachment :principal_photo_attachment, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }
  has_attached_file :logo, url: '/upload/travel/merchant/:id_partition/logo/:updated_at.:extension:style_extension'
  validates_attachment :logo_attachment, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }
end
