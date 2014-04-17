class Travel::Speaking < ActiveRecord::Base
  belongs_to :product
  belongs_to :language

  default_scope { where(active: true) }
end
