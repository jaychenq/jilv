class Business::Travel::InventoriesController < Business::Travel::ApplicationController
  before_action :inventory

  def index
    @inventories = model.business(params)
    @inventories = @inventories.none if !can?(:index, model) && @inventories.many?
  end
  
  private
  def inventory
  end
end
