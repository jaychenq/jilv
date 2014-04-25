class Admin::Travel::ProductsController < Admin::Travel::ApplicationController
  def index
    @products = model.admin(params)
    @products = @products.none if !can?(:index, model) && @products.many?
  end

  def show
  end

  def new
    params[model.table_name.singularize] = model.f(id).attributes.merge(params[model.table_name.singularize].to_h) if id
    @product.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @product.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    @product.save
    render :show, status: @product.valid? ? :accepted : :bad_request
  end

  def edit
    @product.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @product.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    @product.save
    render :show, status: @product.valid? ? :accepted : :bad_request
  end
end
