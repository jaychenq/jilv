class Admin::Travel::TouristsController < Admin::Travel::ApplicationController
  def index
    render template: 'admin/application/index', model: @model
  end
end
