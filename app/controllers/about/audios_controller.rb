class About::AudiosController < About::ApplicationController
  def show
    redirect_to model.f(id).file
  end
end
