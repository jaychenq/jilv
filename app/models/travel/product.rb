class Travel::Product < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :category
  belongs_to :continent
  belongs_to :country
  belongs_to :city
  belongs_to :location
  belongs_to :cover, class_name: Travel::ProductsPhoto
  has_many :journeys
  has_many :inventories
  has_many :parameters
  has_many :speakings
  has_many :photos, class_name: Travel::ProductsPhoto

  default_scope { where(active: true) }

  validates :name, :lowest_price, :latitude, :longitude, :started_on, :ended_on, presence: true
  validates :merchant, :category, :continent, :country, :city, existence: true

  cattr_accessor :admin_fields, :business_fields
  self.business_fields = %w[ name description category_id continent_id country_id city_id location_id lowest_price latitude longitude started_on ended_on cover_id published ]
  self.admin_fields = self.business_fields + %w[ merchant_id ]
end
