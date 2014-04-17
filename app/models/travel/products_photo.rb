class Travel::ProductsPhoto < ActiveRecord::Base
  belongs_to :product

  validates :sequence, numericality: { only_integer: true }, allow_nil: true

  has_attached_file :file, url: '/upload/travel/products_photo/:id_partition/file/:updated_at.:extension:style_extension'
  validates_attachment :file_attachment, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }

  default_scope { where(active: true) }

  cattr_accessor :admin_fields, :business_fields
  self.admin_fields = %w[]
  self.business_fields = %w[ file product_id ]
end
