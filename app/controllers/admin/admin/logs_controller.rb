class Admin::Admin::LogsController < Admin::Admin::ApplicationController
  def index
    @logs = model
      .where(params[:where].to_h.slice(*%w[user_id controller action params_id created_at]))
      .order((params[:order]||{'id'=>:desc}).slice(*%w[id]))
      .paginate(page: params[:page], per_page: params[:per_page])
  end
end
