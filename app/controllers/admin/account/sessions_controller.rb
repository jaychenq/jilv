class Admin::Account::SessionsController < Admin::Account::ApplicationController
  def index
    @sessions = model
      .where(params[:where].to_h.slice(*%w[id]))
      .order((params[:order]||{'id'=>:desc}).slice(*%w[id]))
      .paginate(page: params[:page], per_page: params[:per_page])
    @sessions = @sessions.none unless can?(:index, model) || @sessions.total_entries <= 1
    respond_with(@sessions)
  end
  
  def show
    @session = model.f(params[:id])
    respond_with(@session)
  end
end
