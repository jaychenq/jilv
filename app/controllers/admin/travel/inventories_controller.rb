class Admin::Travel::InventoriesController < Admin::Travel::ApplicationController
  def index
    @inventories = model.admin(params)
    @inventories = @inventories.none if !can?(:index, model) && @inventories.many?
  end

  def show
  end

  def new
    params[model.table_name.singularize] = model.f(id).attributes.merge(params[model.table_name.singularize].to_h) if id
    @inventory.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @inventory.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    @inventory.save
    render :show, status: @inventory.valid? ? :accepted : :bad_request
  end

  def edit
    @inventory.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @inventory.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    @inventory.save
    render :show, status: @inventory.valid? ? :accepted : :bad_request
  end
  
  def batch
    @inventory.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    return if request.get?
    from = Date.parse(params[:started_on_from])
    to = Date.parse(params[:started_on_to])
    (from..to).each do |started_on|
      inventory = model.find_or_initialize_by(journey_id: params[model.table_name.singularize][:journey_id], started_on: started_on)
      inventory.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields).merge(started_on: started_on)
      inventory.save!
    end
  end
end
