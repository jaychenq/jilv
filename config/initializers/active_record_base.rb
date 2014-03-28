module ActiveRecord
  class Base
    class << self
      def f(id)
        records = where(id: id)
        records = records.where(active: true) if self.new.respond_to?(:active?)
        records.first
      end

      def default(params)
        self
          .where(params[:where].to_h.slice(*self.admin_fields).merge(self.new.respond_to?(:active?) && { active: true }))
          .order(params[:order].in?((self.admin_fields + %w[id created_at updated_at]).map { |field| ["#{field} asc", "#{field} desc"] }.flatten) ? params[:order] : 'id desc')
          .paginate(page: params[:page], per_page: params[:per_page])
      end
    end
  end
end
