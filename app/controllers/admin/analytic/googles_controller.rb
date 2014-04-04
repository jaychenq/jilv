class Admin::Analytic::GooglesController < Admin::Analytic::ApplicationController
  def index
    redirect_to 'https://www.google.com/analytics/web/#report/visitors-overview/a49529714w81270694p84142366/'
  end
end
