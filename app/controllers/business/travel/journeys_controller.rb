class Business::Travel::JourneysController < Business::Travel::ApplicationController
  before_action :journey

  def index
    @journeys = model.business(params)
    @journeys = @journeys.none if !can?(:index, model) && @journeys.many?
  end

  def show
  end

  def new
    @journey.attributes = params[model.table_name.singularize].to_h.slice(*model.business_fields)
    render :show
  end

  def create
    @journey.attributes = params[model.table_name.singularize].to_h.slice(*model.business_fields)
    ok = @journey.save
    
    return render :show if !ok
    redirect_to [:journeys, :business, @journey.product]
  end

  def edit
    @journey.attributes = params[model.table_name.singularize].to_h.slice(*model.business_fields)
    render :show
  end

  def update
    @journey.attributes = params[model.table_name.singularize].to_h.slice(*model.business_fields)
    ok = @journey.save

    return render :show if !ok
    redirect_to [:journeys, :business, @journey.product]
  end

private

  def journey
    @journey = model.f(id) if id
    return @journey = Travel::Journey.new if !@journey
    @product = @journey.product
    @merchant = @product.merchant
    return redirect_to [:business, @merchant] if @merchant != @current_user.merchant
  end
end
