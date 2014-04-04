class Admin::Message::EmailsController < Admin::Message::ApplicationController
  def index
    render template: 'admin/application/index', model: @model
  end
end
