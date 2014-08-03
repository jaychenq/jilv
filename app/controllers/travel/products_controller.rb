class Travel::ProductsController < Travel::ApplicationController
  def index
    @products = model.where(published: true).where(params[:where].to_h.slice(*%w[merchant_id continent_id country_id city_id category1_id category2_id])).order(updated_at: :desc).paginate(page: params[:page], per_page: params[:per_page] || 10)
    @products_all = model.where(published: true).order(updated_at: :desc).paginate(page: params[:page], per_page: params[:per_page] || 10)
    @products_for_city = model.where(published: true).where(params[:where].to_h.slice(*%w[country_id])).order(updated_at: :desc).paginate(page: params[:page], per_page: params[:per_page] || 10)
    @products = @products.joins("INNER JOIN travel_speakings ON travel_speakings.product_id = travel_products.id AND travel_speakings.active = TRUE AND travel_speakings.language_id = #{params[:where][:language_id].to_i}") if params[:where] && params[:where][:language_id]
  	render :layout => "product"
  end
  
  def show
    @product = model.f(id)
  end
end
