class Travel::Location < ActiveRecord::Base
  belongs_to :city
  has_many :products
  belongs_to :creator, class_name: Admin::User
  belongs_to :updater, class_name: Admin::User

  validates :name, uniqueness: true, allow_blank: true
  validates :sequence, numericality: { only_integer: true }, allow_nil: true
  validates :city, existence: true, allow_nil: true
  # validates :creator, existence: true, allow_nil: true
  # validates :updater, existence: true, allow_nil: true

  default_scope { where(active: true) }

  has_attached_file :icon, url: '/upload/travel/location/:id_partition/icon/:updated_at.:extension:style_extension'
  validates_attachment :icon_attachment, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }
  has_attached_file :landscape, url: '/upload/travel/location/:id_partition/landscape/:updated_at.:extension:style_extension'
  validates_attachment :landscape_attachment, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }
  has_attached_file :background, url: '/upload/travel/location/:id_partition/background/:updated_at.:extension:style_extension'
  validates_attachment :background_attachment, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }

  cattr_accessor :admin_fields
  self.admin_fields = %w[ city_id name description sequence icon landscape background ]

  def deletable?
    products.empty?
  end
end
