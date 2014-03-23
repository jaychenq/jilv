class Account::SessionsController < ApplicationController
  def index
    redirect_to :root
  end
  
  def new
    @session = Account::Session.new
  end
  
  def create
    @session = Account::Session.new
    @session.attributes = params[:account_session].permit(:email, :password)
    
    if @user = Account::User.find_by(email: @session.email).try(:authenticate, @session.password)
      @session.attributes = { user_id: @user.id, ip_address: request.remote_ip, user_agent: request.env['HTTP_USER_AGENT'], referrer: request.referrer }
      @session.save
      session[:session_id] = @session.id
      
      redirect_to :root
    else
      render 'new'
    end
  end
  
  def destroy
    @session = Account::Session.find(session[:session_id])
    @session.logout
    session.delete(:session_id)
    redirect_to :back
  end
end
