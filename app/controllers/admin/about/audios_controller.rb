class Admin::About::AudiosController < Admin::About::ApplicationController
  def index
    @audios = model.default(params)
    @audios = @audios.none if !can?(:index, model) && @audios.many?
  end

  def show
  end

  def new
    params[model.table_name.singularize] = model.f(id).attributes.merge(params[model.table_name.singularize].to_h) if id
    @audio.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @audio.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields).merge(creator_id: @current_user.id)
    @audio.save
    render :show, status: @page.valid? ? :accepted : :bad_request
  end

  def edit
    @audio.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @audio.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields).merge(updater_id: @current_user.id)
    @audio.save
    render :show, status: @page.valid? ? :accepted : :bad_request
  end
end
