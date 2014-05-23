class Admin::Travel::BookingsController < Admin::Travel::ApplicationController
  def index
    @bookings = model.default(params)
    @bookings = @bookings.limit(1) unless can?(:index, model)
    respond_with(@bookings)
  end

  def show
    @booking = model.f(params[:id])
    respond_with(@booking)
  end
end
