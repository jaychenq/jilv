class Admin::About::VideosController < Admin::About::ApplicationController
  def index
    @videos = model.default(params)
    @videos = @videos.none if !can?(:index, model) && @videos.many?
  end

  def show
  end

  def new
    params[model.table_name.singularize] = model.f(id).attributes.merge(params[model.table_name.singularize].to_h) if id
    @video.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @video.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields).merge(creator_id: @current_user.id)
    @video.save
    render :show, status: @video.valid? ? :accepted : :bad_request
  end

  def edit
    @video.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @video.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields).merge(updater_id: @current_user.id)
    @video.save
    render :show, status: @video.valid? ? :accepted : :bad_request
  end
end
