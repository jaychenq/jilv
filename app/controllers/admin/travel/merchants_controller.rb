class Admin::Travel::MerchantsController < Admin::Travel::ApplicationController
  def index
    @merchants = model.admin(params)
    @merchants = @merchants.none if !can?(:index, model) && @merchants.many?
  end

  def show
  end

  def new
    params[model.table_name.singularize] = model.f(id).attributes.merge(params[model.table_name.singularize].to_h) if id
    @merchant.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @merchant.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    @merchant.save
    render :show, status: @merchant.valid? ? :accepted : :bad_request
  end

  def edit
    @merchant.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @merchant.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    @merchant.save
    render :show, status: @merchant.valid? ? :accepted : :bad_request
  end
end
