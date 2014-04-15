class Admin::ApplicationController < ApplicationController
  layout 'admin'

  before_action :find_record
  before_action :authorize
  before_action :log, if: -> { @current_user }

  def index
    return redirect_to new_account_session_path(redirect: request.fullpath) if !@current_user
    return redirect_to params[:redirect] if params[:redirect].present?
    render text: '', layout: true
  end
  
  def delete
    render template: 'admin/shared/delete'
  end
  
  def destroy
    record = model.f(id)
    raise if !record.respond_to?(:deletable?) || !record.deletable?
    record.attributes = { active: false, updater_id: @current_user.id }
    record.save
    render :show, status: record.valid? ? :accepted : :bad_request
  end

  def publish
    record = model.f(id)
    record.attributes = { published: true, updater_id: @current_user.id }
    record.save
    head record.valid? ? :accepted : :bad_request
  end

  def withdraw
    record = model.f(id)
    record.attributes = { published: false, updater_id: @current_user.id }
    record.save
    head record.valid? ? :accepted : :bad_request
  end
  
  def find_record
    return if !model
    record = id ? model.f(id) : model.new
    instance_variable_set "@#{controller_name.singularize}", record
  end

private

  def authorize
    # @enable_lazyload = !request.xhr?
    
    return redirect_to new_account_session_path(redirect: request.fullpath) if !@current_user
    return redirect_to root_path if !@current_user.admin_user
  end

  def log
    Admin::Log.create({
      user_id: @current_user.id,
      controller: self.class.name.remove(/^Admin::|Controller$/),
      action: self.action_name,
      params_id: params[:id],
    })
  end

  def can?(*argv)
    @current_user.try(:admin_user)#.try(:can?, *argv)
  end
end
