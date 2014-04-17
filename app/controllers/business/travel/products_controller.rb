class Business::Travel::ProductsController < Business::Travel::ApplicationController
  before_action :merchant, :product

  def index
    @products = @merchant.products
  end

  def show
  end

  def new
    @product.attributes = params[model.table_name.singularize].to_h.slice(*model.business_fields)
    render :show
  end

  def create
    @product.attributes = params[model.table_name.singularize].to_h.slice(*model.business_fields).merge(merchant_id: @current_user.id)
    @product.save
    render :show
  end

  def edit
    @product.attributes = params[model.table_name.singularize].to_h.slice(*model.business_fields)
    render :show
  end

  def update
    @product.attributes = params[model.table_name.singularize].to_h.slice(*model.business_fields)
    @product.save
    render :show
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
