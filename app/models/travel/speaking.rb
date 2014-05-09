class Travel::Speaking < ActiveRecord::Base
  belongs_to :product
  belongs_to :language
  
  # validates :language, existence: true

  default_scope { where(active: true) }
end
