class Admin::Travel::CountriesController < Admin::Travel::ApplicationController
  def index
    @countries = model.default(params)
    @countries = @countries.limit(1) unless can?(:index, model)
    respond_with(@countries)
  end

  def show
    @country = model.f(params[:id])
    respond_with(@country)
  end

  def new
    @country = model.new
    params[:travel_country] = model.f(params[:id]).attributes.merge(params[:travel_country].to_h) if params[:id]
    @country.attributes = params[:travel_country].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @country = model.new
    @country.attributes = params[:travel_country].to_h.slice(*model.admin_fields).merge(creator_id: @current_user.id)
    @country.save
    render :show
  end

  def edit
    @country = model.f(params[:id])
    @country.attributes = params[:travel_country].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @country = model.f(params[:id])
    @country.attributes = params[:travel_country].to_h.slice(*model.admin_fields).merge(updater_id: @current_user.id)
    @country.save

    respond_with(@country) do |format|
      format.html { render :show }
      format.js { head @country.valid? ? :accepted : :bad_request }
    end
  end
end
