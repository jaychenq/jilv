class Travel::FavoritesController < Travel::ApplicationController
  def create
    @favorite = @current_user.favorites.find_or_create_by(product_id: params[:travel_favorite][:product_id])
    redirect_to @favorite.product
  end
  
  def destroy
    @favorite = model.f(id)
    @favorite.active = false
    @favorite.save
    # redirect_to @favorite.product
    render text: ''
  end
end
