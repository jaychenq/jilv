class Admin::Travel::CategoriesController < Admin::Travel::ApplicationController
  def index
    @categories = model.default(params)
    @categories = @categories.limit(1) unless can?(:index, model)
    respond_with(@categories)
  end

  def show
    @category = model.f(params[:id])
    respond_with(@category)
  end

  def new
    @category = model.new
    params[:travel_category] = model.f(params[:id]).attributes.merge(params[:travel_category].to_h) if params[:id]
    @category.attributes = params[:travel_category].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @category = model.new
    @category.attributes = params[:travel_category].to_h.slice(*model.admin_fields).merge(creator_id: @current_user.id)
    @category.save
    render :show
  end

  def edit
    @category = model.f(params[:id])
    @category.attributes = params[:travel_category].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @category = model.f(params[:id])
    @category.attributes = params[:travel_category].to_h.slice(*model.admin_fields).merge(updater_id: @current_user.id)
    @category.save

    respond_with(@category) do |format|
      format.html { render :show }
      format.js { head @category.valid? ? :accepted : :bad_request }
    end
  end
end
