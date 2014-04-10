class About::ImagesController < About::ApplicationController
  def show
    redirect_to model.f(id).file
  end
end
