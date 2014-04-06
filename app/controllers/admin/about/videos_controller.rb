class Admin::About::VideosController < Admin::About::ApplicationController
  def index
    render template: 'admin/application/index', model: @model
  end
end
