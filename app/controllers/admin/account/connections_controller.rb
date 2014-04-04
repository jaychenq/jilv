class Admin::Account::ConnectionsController < Admin::Account::ApplicationController
  def index
    render template: 'admin/application/index', model: @model
  end
end
