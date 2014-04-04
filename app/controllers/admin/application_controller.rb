class Admin::ApplicationController < ApplicationController
  layout 'admin'
  
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
    raise if !record.respond_to?(:deletable?) || !record.deletable?
    record = model.f(params[:id])
    record.attributes = { active: false, updater_id: @current_user.id }
    record.save
    instance_variable_set "@#{controller_name.singularize}", record
    render :show
  end

  def publish
    record = model.f(params[:id])
    record.attributes = { published: true, updater_id: @current_user.id }
    record.save
    instance_variable_set "@#{controller_name.singularize}", record
    head record.valid? ? :accepted : :bad_request
  end

  def withdraw
    record = model.f(params[:id])
    record.attributes = { published: false, updater_id: @current_user.id }
    record.save
    instance_variable_set "@#{controller_name.singularize}", record
    head record.valid? ? :accepted : :bad_request
  end

private

  def authorize
    # @enable_lazyload = !request.xhr?
    
    return redirect_to new_account_session_path(redirect: request.fullpath) if !@current_user.try(:admin_user)
  end

  def log
    Admin::Log.create({
      user_id: @current_user.id,
      controller: self.class.name.gsub(/^Admin::|Controller$/, ''),
      action: self.action_name,
      params_id: params[:id],
    })
  end

  def model
    @model ||= self.class.name.gsub(/^Admin|Controller$/, '').singularize.constantize
  end

  def can?(*argv)
    @current_user.try(:admin_user)#.try(:can?, *argv)
  end
end
