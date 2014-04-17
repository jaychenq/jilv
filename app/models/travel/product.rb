class Travel::Product < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :category
  belongs_to :continent
  belongs_to :country
  belongs_to :city
  belongs_to :location
  belongs_to :cover, class_name: Travel::ProductsPhoto
  has_many :journeys
  has_many :parameters
  has_many :speakings
  has_many :photos, class_name: Travel::ProductsPhoto

  default_scope { where(active: true) }

  validates :name, uniqueness: true

  cattr_accessor :admin_fields, :business_fields
  self.admin_fields = %w[ ]
  self.business_fields = %w[ name description category_id continent_id country_id city_id location_id latitude longitude started_on ended_on cover_id published ]

  def deletable?
    journeys.empty?
  end
end
