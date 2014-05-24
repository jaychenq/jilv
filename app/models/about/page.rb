class About::Page < ActiveRecord::Base
  enum position: %i[home merchant]
  enum template: %i[home_1 merchant_1]

  belongs_to :creator, class_name: Admin::User
  belongs_to :updater, class_name: Admin::User

  validates :creator, existence: true, allow_nil: true
  validates :updater, existence: true, allow_nil: true

  default_scope { where(active: true) }

  cattr_accessor :admin_fields
  self.admin_fields = %w[name position title keywords description body template data]
  
  def deletable?
    !published?
  end
  
  class << self
    def search(id_or_position)
      self
        .where(id_or_position.to_s.match(/\A\d+\Z/) ? { id: id_or_position } : { position: self.positions[id_or_position] })
        .where(published: true)
        .order(id: :desc)
        .first
    end
  end
end
