class Business::Travel::ProductsController < Business::Travel::ApplicationController
  before_action :merchant, :product

  def index
    @products = @merchant.products.order(id: :desc)
  end

  def show
  end

  def new
    @product.attributes = params[model.table_name.singularize].to_h.slice(*model.business_fields)
    render :show
  end

  def create
    @product.attributes = params[model.table_name.singularize].to_h.slice(*model.business_fields).merge(merchant_id: @current_user.id)
    @product.colony = params[:colony].join(",")
    ok = @product.save
    
    if ok
      speakings = @product.speakings.to_a
      language_ids = params[:language_ids]
      speakings.find_all { |speaking| !language_ids.include?(speaking.language_id) }.each { |speaking| speaking.update(active: false) }
      language_ids.each { |language_id| Travel::Speaking.where(active: true).find_or_create_by(language_id: language_id, product_id: @product.id) }
      params[:photo_files].to_h.each do |index, file|
        next unless file
        photo = @product.photos.find_or_initialize_by(sequence: index)
        photo.file = file
        photo.save
      end
    end
    
    return render :show if !ok
    redirect_to @product.journeys.empty? ? new_business_travel_journey_path('travel_journey[product_id]' => @product.id) : journeys_business_travel_product_path(@product.id)
  end

  def edit
    @product.attributes = params[model.table_name.singularize].to_h.slice(*model.business_fields)
    render :show
  end

  def update
    @product.attributes = params[model.table_name.singularize].to_h.slice(*model.business_fields)
    ok = @product.save
    
    if ok
      speakings = @product.speakings.to_a
      language_ids = params[:language_ids]
      speakings.find_all { |speaking| !language_ids.include?(speaking.language_id) }.each { |speaking| speaking.update(active: false) }
      language_ids.each { |language_id| Travel::Speaking.where(active: true).find_or_create_by(language_id: language_id, product_id: @product.id) }
      
      params[:photo_files].to_h.each do |index, file|
        next unless file
        photo = @product.photos.find_or_initialize_by(sequence: index)
        photo.file = file
        photo.save
      end
    end
    
    return render :show if !ok
    redirect_to @product.journeys.empty? ? new_business_travel_journey_path('travel_journey[product_id]' => @product.id) : journeys_business_travel_product_path(@product.id,"update"=>"1")
  end

private

  def merchant
    @merchant ||= @current_user.try(:merchant)
    return redirect_to new_business_travel_merchant_path if !@merchant
  end

  def product
    @product ||= model.f(id) if id
    return @product = @merchant.products.new if !@product
    return redirect_to [:business, @merchant] if @merchant != @product.merchant
  end
end
