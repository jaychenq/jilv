class Business::Travel::PhotosController < Business::Travel::ApplicationController
  def create
    @photo = model.new
    @photo.attributes = params[model.table_name.singularize].to_h.slice(*model.business_fields)
    @photo.save
    redirect_to business_travel_product_path(@photo.product.id) # [:businuess, @photo.product]
  end
end
