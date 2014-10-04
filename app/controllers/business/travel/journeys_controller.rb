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
    save_inventories if ok
    
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
    save_inventories if ok

    return render :show if !ok
    redirect_to [:journeys, :business, @journey.product]
  end

  def destroy
    @journey = model.f(id) if id
    product = @journey.product
    @journey.inventories.each do |invent|
      invent.destroy
    end
    @journey.destroy
    redirect_to [:journeys, :business, product]
  end

private

  def journey
    @journey = model.f(id) if id
    return @journey = Travel::Journey.new if !@journey
    @product = @journey.product
    @merchant = @product.merchant
    return redirect_to [:business, @merchant] if @merchant != @current_user.merchant
  end

  def save_inventories
    old_inventories = @journey.inventories.to_a
    new_inventories = (params[:travel_inventory]||[]).each do |i|
      started_on = Date.parse(i.permit(:started_on)[:started_on])
      inventory = old_inventories.find { |inventory| inventory.started_on == started_on } || @journey.inventories.new(started_on: started_on)
      inventory.attributes = i.permit(:adult_price,:adult_mkt_price, :child_price,:child_mkt_price, :total_number)
      next if inventory.new_record? && !inventory.adult_price && !inventory.child_price && !inventory.total_number
      inventory.save
    end
    @product = @journey.product
    @product.update(lowest_price: @product.inventories.where('started_on > ?', Date.today).where('adult_price > 0 AND remained_number > 0').order(adult_price: :asc).first.try(:adult_price).to_i)
    @journey.update(lowest_price: @journey.inventories.where('started_on > ?', Date.today).where('adult_price > 0 AND remained_number > 0').order(adult_price: :asc).first.try(:adult_price).to_i)
  end
end
