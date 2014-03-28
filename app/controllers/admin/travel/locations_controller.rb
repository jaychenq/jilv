class Admin::Travel::LocationsController < Admin::Travel::ApplicationController
  def index
    @locations = model.default(params)
    @locations = @locations.limit(1) unless can?(:index, model)
    respond_with(@locations)
  end

  def show
    @location = model.f(params[:id])
    respond_with(@location)
  end

  def new
    @location = model.new
    params[:travel_location] = model.f(params[:id]).attributes.merge(params[:travel_location].to_h) if params[:id]
    @location.attributes = params[:travel_location].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @location = model.new
    @location.attributes = params[:travel_location].to_h.slice(*model.admin_fields).merge(creator_id: @current_user.id)
    @location.save
    render :show
  end

  def edit
    @location = model.f(params[:id])
    @location.attributes = params[:travel_location].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @location = model.f(params[:id])
    @location.attributes = params[:travel_location].to_h.slice(*model.admin_fields).merge(updater_id: @current_user.id)
    @location.save

    respond_with(@location) do |format|
      format.html { render :show }
      format.js { head @location.valid? ? :accepted : :bad_request }
    end
  end
end
