class Travel::Product < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :category1, class_name: Travel::Category
  belongs_to :category2, class_name: Travel::Category
  belongs_to :continent
  belongs_to :country
  belongs_to :city
  belongs_to :location
  belongs_to :cover, class_name: Travel::Photo
  has_many :journeys
  has_many :inventories
  has_many :photos
  has_many :speakings
  has_many :languages, through: :speakings
  has_many :parameters

  accepts_nested_attributes_for :photos
  accepts_nested_attributes_for :speakings
  accepts_nested_attributes_for :parameters

  default_scope { where(active: true) }

  validates_associated :photos, :speakings, :parameters
  validates :name, :description, :highlight, :address, :activity_time, :colony, :arrival, :tips, presence: true
  validates :merchant, :category1, :category2, :continent, :country, :city, existence: true

  cattr_accessor :admin_fields, :business_fields
  self.business_fields = %w[ name description highlight category1_id category2_id continent_id country_id city_id location_id address lowest_price latitude longitude started_on ended_on activity_time colony early_booking arrival tips cover_id photos_attributes speakings_attributes parameters_attributes ]
  self.admin_fields = self.business_fields + %w[ merchant_id published ]
  
  before_validation do
    self.cover_id = self.photos.sort_by { |photo| photo.sequence.presence || photo.id || 99999999 }.first.try(:id)
    self.category1_id = self.category2.try(:parent).try(:id)
    true
  end
end
