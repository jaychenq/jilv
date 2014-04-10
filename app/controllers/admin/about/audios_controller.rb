class Admin::About::AudiosController < Admin::About::ApplicationController
  def index
    @audios = model.default(params)
    @audios = @audios.none unless can?(:index, model) || !@topics.second
    respond_with(@audios)
  end

  def show
    @audio = model.f(id)
    respond_with(@audio)
  end

  def new
    @audio = model.new
    params[model.table_name.singularize] = model.f(id).attributes.merge(params[model.table_name.singularize].to_h) if id
    @audio.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @audio = model.new
    @audio.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields).merge(creator_id: @current_user.id)
    @audio.save
    render :show
  end

  def edit
    @audio = model.f(id)
    @audio.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @audio = model.f(id)
    @audio.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields).merge(updater_id: @current_user.id)
    @audio.save

    respond_with(@audio) do |format|
      format.html { render :show }
      format.js { head @audio.valid? ? :accepted : :bad_request }
    end
  end
end
