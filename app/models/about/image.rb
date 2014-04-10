class About::Image < ActiveRecord::Base
  belongs_to :page

  belongs_to :creator, class_name: Admin::User
  belongs_to :updater, class_name: Admin::User

  validates :page, existence: true, allow_nil: true
  validates :creator, existence: true, allow_nil: true
  validates :updater, existence: true, allow_nil: true

  cattr_accessor :admin_fields
  self.admin_fields = %w[page_id name file]

  has_attached_file :file, url: '/upload/about/image/:id_partition/file/:updated_at.:extension:style_extension'
  validates_attachment :file_attachment, content_type: { content_type: %w[image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif] }
end
