class Travel::Category < ActiveRecord::Base
  belongs_to :parent, class_name: self
  has_many :children, class_name: self, foreign_key: 'parent_id'
  belongs_to :creator, class_name: Admin::User
  belongs_to :updater, class_name: Admin::User

  validates :name, uniqueness: true, allow_blank: true
  validates :sequence, numericality: { only_integer: true }, allow_nil: true
  validates :parent, existence: true, allow_nil: true
  validates :creator, existence: true, allow_nil: true
  validates :updater, existence: true, allow_nil: true

  scope :active, -> { where active: true }
  scope :published, -> { where published: true }

  cattr_accessor :admin_fields
  self.admin_fields = %w[parent_id name description sequence]

  def deletable?
    children.empty?
  end
end