class Admin::Travel::FavoritesController < Admin::Travel::ApplicationController
  def index
    @favorites = model.admin(params)
    @favorites = @favorites.none if !can?(:index, model) && @favorites.many?
  end

  def show
  end

  def new
    params[model.table_name.singularize] = model.f(id).attributes.merge(params[model.table_name.singularize].to_h) if id
    @favorite.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @favorite.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    @favorite.save
    render :show, status: @favorite.valid? ? :accepted : :bad_request
  end

  def edit
    @favorite.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @favorite.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    @favorite.save
    render :show, status: @favorite.valid? ? :accepted : :bad_request
  end
end
