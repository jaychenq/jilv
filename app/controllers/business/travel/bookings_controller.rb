class Business::Travel::BookingsController < Business::Travel::ApplicationController
  before_action :merchant, :booking

  def index
    @bookings = @merchant.bookings.order(id: :desc).paginate(page: params[:page], per_page: params[:per_page] || 1000)
  end
  
  def accept
    @booking.confirmation = true
    @booking.save
    Mailer.mail(to: @booking.user.email, subject: "[极旅]你的预订#{@booking.product.try(:name)}已确认，请及时支付", body: %{<a href="#{url_for(@booking)}">#{url_for(@booking)}</a>})
    redirect_to :back
    
  end
  
  def reject
    @booking.confirmation = false
    @booking.save
    Mailer.mail(to: @booking.user.email, subject: "[极旅]很抱歉，你的预订#{@booking.product.try(:name)}已售完", body: %{<a href="#{url_for(@booking)}">#{url_for(@booking)}</a>})
    redirect_to :back
  end

private

  def merchant
    @merchant ||= @current_user.try(:merchant)
    return redirect_to new_business_travel_merchant_path if !@merchant
  end
  
  def booking
    @booking = model.f(id) if id
  end
end
