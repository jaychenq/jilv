class Travel::Parameter < ActiveRecord::Base
  belongs_to :product
  belongs_to :travel_attribute
  
  default_scope { where(active: true) }
end
