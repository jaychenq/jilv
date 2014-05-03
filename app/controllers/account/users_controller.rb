class Account::UsersController < ApplicationController
  def show
    @user = Account::User.find(params[:id])
  end

  def new
    @user = Account::User.new
  end

  def create
    @user = Account::User.new
    @user.attributes = params[:account_user].permit(*%w[name gender avatar email password terms_of_service])
    @user.save

    if @user.valid?
      account_session = Account::Session.create(user_id: @user.id, ip_address: request.remote_ip, user_agent: request.env['HTTP_USER_AGENT'], referrer: request.referrer)
      session[:session_id] = account_session.id
      Mailer.mail(to: @user.email, subject: '欢迎成为极旅用户！', body: "欢迎欢迎<br />from极旅团队")

      redirect_to params[:redirect].presence || :root
    else
      render :new
    end
  end
end
