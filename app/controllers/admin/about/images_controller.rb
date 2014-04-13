class Admin::About::ImagesController < Admin::About::ApplicationController
  def index
    @images = model.default(params)
    @images = @images.none if !can?(:index, model) && @images.many?
  end

  def show
  end

  def new
    params[model.table_name.singularize] = model.f(id).attributes.merge(params[model.table_name.singularize].to_h) if id
    @image.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @image.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields).merge(creator_id: @current_user.id)
    @image.save
    render :show, status: @image.valid? ? :accepted : :bad_request
  end

  def edit
    @image.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @image.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields).merge(updater_id: @current_user.id)
    @image.save
    render :show, status: @image.valid? ? :accepted : :bad_request
  end
end
