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

  def confirm
  end

  def confirm_data
  	@booking.attributes = params[model.table_name.singularize].to_h.slice(*model.admin_fields)
    @booking.do_confirm = "do"
    @booking.save
    respond_with(@booking)
  end
end
