class Business::ApplicationController < ApplicationController
  before_action :user_required

private

  def user_required
    redirect_to new_account_session_path(redirect: request.fullpath) if !@current_user
  end

  def can?(*argv)
    @current_user
  end
end
