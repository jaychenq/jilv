module ActiveRecord
  class Base
    def self.f(id)
      record = where(id: id)
      record = record.where(active: true) if record.first.respond_to?(:active?)
      record.first
    end
  end
end
