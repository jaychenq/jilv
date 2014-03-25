class Admin::ApplicationController < ApplicationController
  layout 'admin'
  
  before_action :authorize
  before_action :log, if: -> { @current_user }

  def index
    return redirect_to new_account_session_path(redirect: request.fullpath) if !@current_user
    return redirect_to params[:redirect] if params[:redirect].present?
    render text: '', layout: true
  end

private

  def authorize
    @enable_lazyload = !request.xhr?
    
    return true if params[:controller] == 'admin/application' || (@current_user && params[:controller] =~ /\/application\W*/)
    return redirect_to controller: admin_root_path, redirect: request.fullpath if !@current_user.try(:admin_user)
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
