class Travel::Category < ActiveRecord::Base
  belongs_to :parent, class_name: self
  has_many :children, class_name: self, foreign_key: 'parent_id'
  has_many :_attributes
  has_many :products
  belongs_to :creator, class_name: Admin::User
  belongs_to :updater, class_name: Admin::User

  validates :name, presence: true, allow_blank: true
  validates :sequence, numericality: { only_integer: true }, allow_nil: true
  validates :parent, existence: true, allow_nil: true
  # validates :creator, existence: true, allow_nil: true
  # validates :updater, existence: true, allow_nil: true

  default_scope { where(active: true) }

  has_attached_file :icon, url: '/upload/travel/category/:id_partition/icon/:updated_at.:extension:style_extension'
  validates_attachment :icon_attachment, size: { in: 0..10.megabytes }, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }
  has_attached_file :landscape, url: '/upload/travel/category/:id_partition/landscape/:updated_at.:extension:style_extension'
  validates_attachment :landscape_attachment, size: { in: 0..10.megabytes }, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }
  has_attached_file :background, url: '/upload/travel/category/:id_partition/background/:updated_at.:extension:style_extension'
  validates_attachment :background_attachment, size: { in: 0..10.megabytes }, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }

  cattr_accessor :admin_fields
  self.admin_fields = %w[ parent_id name description sequence icon landscape background ]

  def deletable?
    [children, _attributes, products].all(&:empty?)
  end
end
