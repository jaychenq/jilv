class Admin::Travel::ContinentsController < Admin::Travel::ApplicationController
  def index
    @continents = model.default(params)
    @continents = @continents.limit(1) unless can?(:index, model)
    respond_with(@continents)
  end

  def show
    @continent = model.f(params[:id])
    respond_with(@continent)
  end

  def new
    @continent = model.new
    params[:travel_continent] = model.f(params[:id]).attributes.merge(params[:travel_continent].to_h) if params[:id]
    @continent.attributes = params[:travel_continent].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @continent = model.new
    @continent.attributes = params[:travel_continent].to_h.slice(*model.admin_fields).merge(creator_id: @current_user.id)
    @continent.save
    render :show
  end

  def edit
    @continent = model.f(params[:id])
    @continent.attributes = params[:travel_continent].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @continent = model.f(params[:id])
    @continent.attributes = params[:travel_continent].to_h.slice(*model.admin_fields).merge(updater_id: @current_user.id)
    @continent.save

    respond_with(@continent) do |format|
      format.html { render :show }
      format.js { head @continent.valid? ? :accepted : :bad_request }
    end
  end
end
