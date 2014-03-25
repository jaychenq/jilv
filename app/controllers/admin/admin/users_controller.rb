class Admin::Admin::UsersController < Admin::Admin::ApplicationController
  def index
    @users = model
      .where(params[:where].to_h.slice(*%w[id]))
      .order((params[:order]||{'id'=>:desc}).slice(*%w[id]))
      .paginate(page: params[:page], per_page: params[:per_page])
    @users = @users.where('FALSE') unless can?(:index, model) || @users.total_entries <= 1
    respond_with(@users)
  end
  
  def show
    @user = model.f(params[:id])
    respond_with(@user)
  end
  
  def new
    @user = model.new
    params[:admin_user] = model.acquire(params[:id]).attributes.merge(params[:admin_user].to_h) if params[:id]
    @user.attributes = params[:admin_user].to_h.slice(*%w[id])
    render :show
  end
  
  def create
    @user = model.find_or_initialize_by(params[:admin_user].permit(*%w[id]))
    return redirect_to [:admin, @user] if !@user.new_record?
    @user.attributes = { creator_id: @current_user.id }
    @user.save
    render :show
  end
end
