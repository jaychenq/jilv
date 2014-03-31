class Travel::Country < ActiveRecord::Base
  belongs_to :continent
  has_many :cities
  belongs_to :creator, class_name: Admin::User
  belongs_to :updater, class_name: Admin::User

  validates :name, uniqueness: true, allow_blank: true
  validates :sequence, numericality: { only_integer: true }, allow_nil: true
  validates :phone_code, numericality: { only_integer: true }, uniqueness: true, allow_nil: true
  validates :continent, existence: true, allow_nil: true
  validates :creator, existence: true, allow_nil: true
  validates :updater, existence: true, allow_nil: true

  scope :active, -> { where active: true }
  scope :published, -> { where published: true }

  cattr_accessor :admin_fields
  self.admin_fields = %w[continent_id name description sequence phone_code]

  def deletable?
    cities.empty?
  end
end
