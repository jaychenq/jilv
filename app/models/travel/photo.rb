class Travel::Photo < ActiveRecord::Base
  belongs_to :product

  validates :sequence, numericality: { only_integer: true }, allow_nil: true

  has_attached_file :file, url: '/upload/travel/photo/:id_partition/file/:updated_at.:extension:style_extension', styles: { :'640x360' => '640x360#', :'72x50' => '72x50#' }
  validates_attachment :file_attachment, size: { in: 0..10.megabytes }, content_type: { content_type: %w[ image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif ] }

  default_scope { where(active: true) }

  cattr_accessor :admin_fields, :business_fields
  self.business_fields = %w[ file product_id ]
  self.admin_fields = self.business_fields + %w[]
end
