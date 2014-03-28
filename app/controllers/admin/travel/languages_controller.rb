class Admin::Travel::LanguagesController < Admin::Travel::ApplicationController
  def index
    @languages = model.default(params)
    @languages = @languages.limit(1) unless can?(:index, model)
    respond_with(@languages)
  end

  def show
    @language = model.f(params[:id])
    respond_with(@language)
  end

  def new
    @language = model.new
    params[:travel_language] = model.f(params[:id]).attributes.merge(params[:travel_language].to_h) if params[:id]
    @language.attributes = params[:travel_language].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @language = model.new
    @language.attributes = params[:travel_language].to_h.slice(*model.admin_fields).merge(creator_id: @current_user.id)
    @language.save
    render :show
  end

  def edit
    @language = model.f(params[:id])
    @language.attributes = params[:travel_language].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @language = model.f(params[:id])
    @language.attributes = params[:travel_language].to_h.slice(*model.admin_fields).merge(updater_id: @current_user.id)
    @language.save

    respond_with(@language) do |format|
      format.html { render :show }
      format.js { head @language.valid? ? :accepted : :bad_request }
    end
  end
end
