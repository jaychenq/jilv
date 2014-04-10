class Admin::About::PagesController < Admin::About::ApplicationController
  def index
    @pages = model.default(params)
    @pages = @pages.none unless can?(:index, model) || !@topics.second
    respond_with(@pages)
  end

  def show
    @page = model.f(id)
    respond_with(@page)
  end

  def new
    @page = model.new
    params[model.table_name.singularize] = model.f(id).attributes.merge(params[model.table_name.singularize].to_h) if id
    @page.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @page = model.new
    @page.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields).merge(creator_id: @current_user.id)
    @page.save
    render :show
  end

  def edit
    @page = model.f(id)
    @page.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @page = model.f(id)
    @page.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields).merge(updater_id: @current_user.id)
    @page.save

    respond_with(@page) do |format|
      format.html { render :show }
      format.js { head @page.valid? ? :accepted : :bad_request }
    end
  end
end
