class Travel::BookingsController < Travel::ApplicationController
  before_action :booking, except: [:new]

  def index
    @bookings = @current_user.bookings.order(id: :desc).paginate(page: params[:page], per_page: params[:per_page] || 100)
  end

  def show
  end

  def new
    @booking = model.new
    @booking.attributes = params[:travel_booking].to_h
  end

  def create
    @booking = model.new
    @booking.attributes = params[:travel_booking].to_h.merge(user_id: @current_user.id)
    @booking.inventory = @booking.journey.inventories.find_by(started_on: @booking.started_on)
    ok = @booking.save
    
    if ok
      @booking.inventory.preserved_number += @booking.adult_number.to_i + @booking.child_number.to_i
      @booking.inventory.save
      # Mailer.mail(to: @booking.merchant.user.email, subject: "[极旅]用户向你预订了#{@booking.product.name}，请及时确认", body: %{<a href="#{url_for([:business, Travel::Booking])}">#{url_for([:business, Travel::Booking])}</a>})
      redirect_to @booking
    else
      render :new
    end
  end

private

  def booking
    return redirect_to new_account_user_path if !@current_user
    @booking = model.f(id) if id
    return redirect_to action: 'index' if @booking && @booking.user_id != @current_user.id
  end
end
