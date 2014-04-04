class Admin::Message::NotificationsController < Admin::Message::ApplicationController
  def index
    render template: 'admin/application/index', model: @model
  end
end
