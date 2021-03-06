class Travel::Language < ActiveRecord::Base
  has_many :speakings
  has_many :products, through: :speakings
  belongs_to :creator, class_name: Admin::User
  belongs_to :updater, class_name: Admin::User

  validates :locale, uniqueness: true, allow_blank: true
  validates :name, uniqueness: true, allow_blank: true
  validates :sequence, numericality: { only_integer: true }, allow_nil: true
  # validates :creator, existence: true, allow_nil: true
  # validates :updater, existence: true, allow_nil: true

  default_scope { where(active: true) }

  has_attached_file :icon, url: '/upload/travel/language/:id_partition/icon/:updated_at.:extension:style_extension'
  validates_attachment :icon_attachment, size: { in: 0..10.megabytes }, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }

  cattr_accessor :admin_fields
  self.admin_fields = %w[ locale name description sequence icon ]

  def deletable?
    [speakings, products].all?(&:empty?)
  end
end
