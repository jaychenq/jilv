class Business::Travel::MerchantsController < Business::Travel::ApplicationController
  before_action :merchant
  skip_before_action :user_required, only: :new

  def show
  end

  def new
    return redirect_to new_account_user_path(redirect: request.fullpath) if !@current_user
    @merchant = model.new
    @merchant.attributes = params[model.table_name.singularize].to_h.slice(*model.business_fields)
  end

  def create
    @merchant.id = @current_user.id
    @merchant.attributes = params[model.table_name.singularize].to_h.slice(*model.business_fields)

    if @merchant.save then redirect_to [:business, @merchant]
    else render :new
    end
  end

private

  def merchant
    @merchant ||= @current_user.try(:merchant)
    if params[:action].in?(%w[new create])
      return redirect_to [:business, @merchant] if @merchant
      return @merchant = model.new
    end
    return redirect_to action: 'new' if !@merchant
    return redirect_to [:business, @merchant] if id != @merchant.id
  end
end
