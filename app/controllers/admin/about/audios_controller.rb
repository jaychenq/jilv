class Admin::About::AudiosController < Admin::About::ApplicationController
  def index
    render template: 'admin/application/index', model: @model
  end
end
