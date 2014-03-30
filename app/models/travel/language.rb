class Travel::Language < ActiveRecord::Base
  belongs_to :creator, class_name: Admin::User
  belongs_to :updater, class_name: Admin::User

  validates :locale, uniqueness: true, allow_blank: true
  validates :name, uniqueness: true, allow_blank: true
  validates :sequence, numericality: { only_integer: true }, allow_nil: true
  validates :creator, existence: true, allow_nil: true
  validates :updater, existence: true, allow_nil: true

  scope :active, -> { where active: true }
  scope :published, -> { where published: true }

  cattr_accessor :admin_fields
  self.admin_fields = %w[locale name description sequence]

  def deletable?
    
  end
end
