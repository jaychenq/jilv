class Admin::Travel::CitiesController < Admin::Travel::ApplicationController
  def index
    @cities = model.default(params)
    @cities = @cities.limit(1) unless can?(:index, model)
    respond_with(@cities)
  end

  def show
    @city = model.f(params[:id])
    respond_with(@city)
  end

  def new
    @city = model.new
    params[:travel_city] = model.f(params[:id]).attributes.merge(params[:travel_city].to_h) if params[:id]
    @city.attributes = params[:travel_city].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @city = model.new
    @city.attributes = params[:travel_city].to_h.slice(*model.admin_fields).merge(creator_id: @current_user.id)
    @city.save
    render :show
  end

  def edit
    @city = model.f(params[:id])
    @city.attributes = params[:travel_city].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @city = model.f(params[:id])
    @city.attributes = params[:travel_city].to_h.slice(*model.admin_fields).merge(updater_id: @current_user.id)
    @city.save

    respond_with(@city) do |format|
      format.html { render :show }
      format.js { head @city.valid? ? :accepted : :bad_request }
    end
  end
end
