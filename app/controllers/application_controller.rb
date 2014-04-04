class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  respond_to :html, :js, :json
  
  before_action :current_user
  before_action :set_locale
  
private
  def current_user
    return @current_user if @current_user
    return if !session[:session_id]
    account_session = Account::Session.find_by(id: session[:session_id])
    return session[:session_id] = nil if !account_session || account_session.expired_at && account_session.expired_at < Time.now
    @current_user = account_session.user
  end

  def set_locale
    locales = [params[:locale], cookies[:locale], session[:locale], request.env['HTTP_ACCEPT_LANGUAGE'].to_s.gsub(/-(\w+)/, &:upcase).split(';').first.to_s.split(',').reverse, I18n.default_locale].flatten.compact
    I18n.locale = session[:locale] = (locales & I18n.available_locales.map(&:to_s)).first
    I18n.locale = 'zh-CN' if params[:controller] !~ /\Aadmin\//
  end
end
