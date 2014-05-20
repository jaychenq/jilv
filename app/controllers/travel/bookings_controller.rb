class Travel::BookingsController < Travel::ApplicationController
  def index
    @bookings = @current_user.bookings.order(id: :desc).paginate(page: params[:page], per_page: params[:per_page] || 100)
  end

  def show
    @booking = model.f(id)
  end

  def new
    @booking = model.new
    @booking.attributes = params[:travel_booking].to_h
  end

  def create
    return redirect_to new_account_user_path if !@current_user
    @booking = model.new
    @booking.attributes = params[:travel_booking].to_h.merge(user_id: @current_user.id)
    ok = @booking.save
    
    if ok then redirect_to @booking
    else render :new
    end
  end
end
