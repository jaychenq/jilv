#encoding:utf-8
class Account::SessionsController < ApplicationController
  def index
    redirect_to :root
  end

  def show
    redirect_to :root
  end

  def new
    @session = Account::Session.new
  end
  
  def create
    @session = Account::Session.new
    @session.attributes = params[:account_session].permit(:name, :password)
    
    if @user = Account::User.find_by(name: @session.name).try(:authenticate, @session.password)
      @session.attributes = { user_id: @user.id, ip_address: request.remote_ip, user_agent: request.env['HTTP_USER_AGENT'], referrer: request.referrer }
      @session.save
      session[:session_id] = @session.id

      if params[:redirect].index("/account/users/new") != -1
         params.delete(:redirect)
      end
      
      redirect_to params[:redirect].presence || :root
    else
      @msg = "登录失败，请确认账号和密码是正确的"
      render 'new',:collection => @msg
    end
  end
  
  def destroy
    @session = Account::Session.find(session[:session_id])
    @session.logout
    session.delete(:session_id)
    redirect_to :back
  end
end
