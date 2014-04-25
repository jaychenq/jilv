class Admin::Travel::JourneysController < Admin::Travel::ApplicationController
  def index
    @journeys = model.admin(params)
    @journeys = @journeys.none if !can?(:index, model) && @journeys.many?
  end

  def show
  end

  def new
    params[model.table_name.singularize] = model.f(id).attributes.merge(params[model.table_name.singularize].to_h) if id
    @journey.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @journey.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    @journey.save
    render :show, status: @journey.valid? ? :accepted : :bad_request
  end

  def edit
    @journey.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @journey.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    @journey.save
    render :show, status: @journey.valid? ? :accepted : :bad_request
  end
end
