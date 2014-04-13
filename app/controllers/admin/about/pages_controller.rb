class Admin::About::PagesController < Admin::About::ApplicationController
  def index
    @pages = model.default(params)
    @pages = @pages.none if !can?(:index, model) && @pages.many?
  end

  def show
  end

  def new
    params[model.table_name.singularize] = model.f(id).attributes.merge(params[model.table_name.singularize].to_h) if id
    @page.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def create
    @page.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields).merge(creator_id: @current_user.id)
    @page.save
    render :show, status: @page.valid? ? :accepted : :bad_request
  end

  def edit
    @page.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    render :show
  end

  def update
    @page.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields).merge(updater_id: @current_user.id)
    @page.save
    render :show, status: @page.valid? ? :accepted : :bad_request
  end
end
