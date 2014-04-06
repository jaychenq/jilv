class Admin::About::ImagesController < Admin::About::ApplicationController
  def index
    render template: 'admin/application/index', model: @model
  end
end
