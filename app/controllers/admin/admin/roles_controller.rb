class Admin::Admin::RolesController < Admin::Admin::ApplicationController
  def index
    render template: 'admin/application/index', model: @model
  end
end
