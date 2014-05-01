class Business::Travel::ProductsPhotosController < Business::Travel::ApplicationController
  def create
    @products_photo = model.new
    @products_photo.attributes = params[model.table_name.singularize].to_h.slice(*model.business_fields)
    @products_photo.save
    redirect_to business_travel_product_path(@products_photo.product.id) # [:businuess, @products_photo.product]
  end
end
