class Admin::About::VideosController < Admin::About::ApplicationController
  def index
    @videos = model.default(params)
    @videos = @videos.none unless can?(:index, model) || !@topics.second
    respond_with(@videos)
  end

  def show
    @video = model.f(id)
    respond_with(@video)
  end

  def new
    @video = model.new
    params[model.table_name.singularize] = model.f(id).attributes.merge(params[model.table_name.singularize].to_h) if id
    @video.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @video = model.new
    @video.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields).merge(creator_id: @current_user.id)
    @video.save
    render :show
  end

  def edit
    @video = model.f(id)
    @video.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @video = model.f(id)
    @video.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields).merge(updater_id: @current_user.id)
    @video.save

    respond_with(@video) do |format|
      format.html { render :show }
      format.js { head @video.valid? ? :accepted : :bad_request }
    end
  end
end
