class Admin::About::ImagesController < Admin::About::ApplicationController
  def index
    @images = model.default(params)
    @images = @images.none unless can?(:index, model) || !@topics.second
    respond_with(@images)
  end

  def show
    @image = model.f(id)
    respond_with(@image)
  end

  def new
    @image = model.new
    params[model.table_name.singularize] = model.f(id).attributes.merge(params[model.table_name.singularize].to_h) if id
    @image.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @image = model.new
    @image.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields).merge(creator_id: @current_user.id)
    @image.save
    render :show
  end

  def edit
    @image = model.f(id)
    @image.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @image = model.f(id)
    @image.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields).merge(updater_id: @current_user.id)
    @image.save

    respond_with(@image) do |format|
      format.html { render :show }
      format.js { head @image.valid? ? :accepted : :bad_request }
    end
  end
end
