class Admin::Travel::AttributesController < Admin::Travel::ApplicationController
  def index
    @attributes = model.default(params)
    @attributes = @attributes.limit(1) unless can?(:index, model)
    respond_with(@attributes)
  end

  def show
    @attribute = model.f(params[:id])
    respond_with(@attribute)
  end

  def new
    @attribute = model.new
    params[:travel_attribute] = model.f(params[:id]).attributes.merge(params[:travel_attribute].to_h) if params[:id]
    @attribute.attributes = params[:travel_attribute].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @attribute = model.new
    @attribute.attributes = params[:travel_attribute].to_h.slice(*model.admin_fields).merge(creator_id: @current_user.id)
    @attribute.save
    render :show
  end

  def edit
    @attribute = model.f(params[:id])
    @attribute.attributes = params[:travel_attribute].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @attribute = model.f(params[:id])
    @attribute.attributes = params[:travel_attribute].to_h.slice(*model.admin_fields).merge(updater_id: @current_user.id)
    @attribute.save

    respond_with(@attribute) do |format|
      format.html { render :show }
      format.js { head @attribute.valid? ? :accepted : :bad_request }
    end
  end
end
