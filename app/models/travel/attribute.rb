class Travel::Attribute < ActiveRecord::Base
  belongs_to :category
  has_many :parameters
  has_many :products, through: :parameters
  belongs_to :creator, class_name: Admin::User
  belongs_to :updater, class_name: Admin::User

  validates :name, uniqueness: true, allow_blank: true
  validates :sequence, numericality: { only_integer: true }, allow_nil: true
  validates :category, existence: true, allow_nil: true
  # validates :creator, existence: true, allow_nil: true
  # validates :updater, existence: true, allow_nil: true

  default_scope { where(active: true) }

  has_attached_file :icon, url: '/upload/travel/attribute/:id_partition/icon/:updated_at.:extension:style_extension'
  validates_attachment :icon_attachment, size: { in: 0..10.megabytes }, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }

  cattr_accessor :admin_fields
  self.admin_fields = %w[ category_id name description sequence options icon ]

  def deletable?
    parameters.empty?
  end
end
