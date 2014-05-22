class Travel::Merchant < ActiveRecord::Base
  enum entity: %i[individual enterprise institution organization agent]
  enum gender: %i[male female]
  enum status: %i[applied approved vetoed forbidden]

  belongs_to :continent
  belongs_to :country
  belongs_to :city
  # belongs_to :phone_country, class_name: Travel::Country
  belongs_to :approved_by, class_name: Admin::User
  belongs_to :vetoed_by, class_name: Admin::User
  belongs_to :forbidden_by, class_name: Admin::User
  has_many :products
  has_many :journeys
  has_many :inventories
  has_many :bookings

  validates :entity, :name, :first_name, :last_name, :gender, :identification, :company, :address, :phone_number, :logo, :description, presence: true
  validates :continent, :country, :city, existence: true

  cattr_accessor :admin_fields, :business_fields
  self.business_fields = %w[ entity name website continent_id country_id city_id address latitude longitude phone_number email qq wechat skype logo description first_name last_name gender company identification lisense ]
  self.admin_fields = self.business_fields + %w[]

  has_attached_file :identification, url: '/upload/travel/merchant/:id_partition/identification/:updated_at.:extension:style_extension'
  validates_attachment :identification_attachment, size: { in: 0..10.megabytes }
  has_attached_file :lisense, url: '/upload/travel/merchant/:id_partition/lisense/:updated_at.:extension:style_extension'
  validates_attachment :lisense_attachment, size: { in: 0..10.megabytes }
  has_attached_file :logo, url: '/upload/travel/merchant/:id_partition/logo/:updated_at.:extension:style_extension', styles: { :'128x128' => '128x128#' }
  validates_attachment :logo_attachment, size: { in: 0..10.megabytes }, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }
end
