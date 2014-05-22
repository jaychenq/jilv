class Travel::FavoritesController < Travel::ApplicationController
  before_action :favorite

  def create
    @favorite = @current_user.favorites.find_or_create_by(product_id: params[:travel_favorite][:product_id])
    redirect_to @favorite.product
  end
  
  def destroy
    @favorite.active = false
    @favorite.save
    # redirect_to @favorite.product
    render text: ''
  end

private

  def favorite
    return redirect_to new_account_user_path if !@current_user
    @favorite = model.f(id) if id
  end
end
