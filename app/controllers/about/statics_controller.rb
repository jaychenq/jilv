class About::StaticsController < About::ApplicationController  
  layout false

  def index
    render template: "about/statics/#{params[:path]}" if params[:path].present?
  end
end
