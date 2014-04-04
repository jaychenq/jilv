class Admin::Travel::ComplaintsController < Admin::Travel::ApplicationController
  def index
    render template: 'admin/application/index', model: @model
  end
end
