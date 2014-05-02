class Travel::Product < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :category
  belongs_to :continent
  belongs_to :country
  belongs_to :city
  belongs_to :location
  belongs_to :cover, class_name: Travel::Photo
  has_many :journeys
  has_many :inventories
  has_many :photos
  has_many :speakings
  has_many :parameters

  accepts_nested_attributes_for :photos
  accepts_nested_attributes_for :speakings
  accepts_nested_attributes_for :parameters

  default_scope { where(active: true) }

  validates_associated :photos, :speakings, :parameters
  validates :name, :lowest_price, :started_on, :ended_on, presence: true # , :latitude, :longitude
  validates :merchant, :category, :continent, :country, :city, existence: true

  cattr_accessor :admin_fields, :business_fields
  self.business_fields = %w[ name description category_id continent_id country_id city_id location_id lowest_price latitude longitude started_on ended_on cover_id photos_attributes speakings_attributes parameters_attributes ]
  self.admin_fields = self.business_fields + %w[ merchant_id published ]
  
  before_save do
    self.cover_id = self.photos.sort_by { |photo| photo.sequence.presence || photo.id }.first.try(:id)
  end
end
