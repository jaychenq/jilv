class Travel::ProductsController < Travel::ApplicationController
  def index
  end
  
  def show
    @product = model.f(id)
  end
end
