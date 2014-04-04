class Admin::Analytic::StatisticsController < Admin::Analytic::ApplicationController
  def index
    render template: 'admin/application/index', model: @model
  end
end
