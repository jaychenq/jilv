class Admin::Account::UsersController < Admin::Account::ApplicationController
  def index
    @users = model
      .where(params[:where].to_h.slice(*%w[id]))
      .order((params[:order]||{'id'=>:desc}).slice(*%w[id]))
      .paginate(page: params[:page], per_page: params[:per_page])
    @users = @users.none unless can?(:index, model) || @users.total_entries <= 1
    respond_with(@users)
  end
  
  def show
    @user = model.f(params[:id])
    respond_with(@user)
  end
end
