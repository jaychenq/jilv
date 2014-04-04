class Admin::Admin::AssignmentsController < Admin::Admin::ApplicationController
  def index
    render template: 'admin/application/index', model: @model
  end
end
