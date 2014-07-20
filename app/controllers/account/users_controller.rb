require 'securerandom'

class Account::UsersController < ApplicationController
  before_action :user_required, only: [ :show, :edit, :update, :password, :setting ]

  def show
    @user = Account::User.find(params[:id])
    
  end

  def new
    @user = Account::User.new
  end

  def forget_mail
      reset_token = SecureRandom.hex
      @user = Account::User.where(:name=>params[:name])
      @result = "0"
      if @user.blank?
        @result = "1"
      else
        @result = "2"
        @user.first.reset_token = reset_token
        @user.first.save
        UserMailer.foget_pass(params[:name],reset_token).deliver
      end
      render :action => "forget", :collection=>@result
  end

  def reset_password
      @user = Account::User.where(:name=>params[:name])

      if @user.blank?
        @result = "3"
        render :action => "forget", :collection=>@result
        return
      end

      if @user.first.reset_token != params[:reset_token]
        @result = "4"
        render :action => "forget", :collection=>@result
        return
      end
  end

  def reset_passwd
    @user = Account::User.where(:name=>params[:name])
    if @user.blank?
        @result = "3"
        render :action => "forget", :collection=>@result
        return
    end
    reset_token = SecureRandom.hex
    @user.first.reset_token = reset_token
    @user.first.save
    @user.first.update(password: params[:password])
    redirect_to "/account/users/reset_password_ok"
  end

  def ajaxValidateFieldName
    name = params[:fieldValue]
    @users = Account::User.where(:name=>name)
    result = []
    result[0] = params[:fieldId]
    if @users.blank?
      result[1] = false
    else
      result[1] = true
    end
    render :json => result, status => :OK
  end

  def create
    @user = Account::User.new
    @user.attributes = params[:account_user].permit(*%w[name gender avatar password terms_of_service])
    @user.save

    if @user.valid?
      account_session = Account::Session.create(user_id: @user.id, ip_address: request.remote_ip, user_agent: request.env['HTTP_USER_AGENT'], referrer: request.referrer)
      session[:session_id] = account_session.id
      Mailer.mail(to: @user.email, subject: '欢迎成为极旅用户！', body: "欢迎欢迎<br />from极旅团队")

      if params[:redirect].index("/account/users/new") != -1 || params[:redirect].index("account/sessions/new") != -1
        params.delete(:redirect)
      end

      redirect_to params[:redirect].presence || :root
    else
      render :new
    end
  end

  def edit
  end

  def update
    @user.attributes = params[:account_user].permit(*%w[name gender avatar])
    @user.save
    render action: 'edit'
  end

  def password
    return render if request.get?
    @user.update(password: params[:new_password]) if params[:new_password] == params[:confirm_new_password] && @user.authenticate(params[:old_password])
  end

  def setting
  end

private

  def user_required
    @user = @current_user
    return redirect_to new_account_session_path if !@user
  end
end
