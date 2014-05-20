class Business::Travel::BookingsController < Business::Travel::ApplicationController
  before_action :merchant

  def index
    @bookings = @merchant.bookings.order(id: :desc).paginate(page: params[:page], per_page: params[:per_page] || 1000)
  end

private

  def merchant
    @merchant ||= @current_user.try(:merchant)
    return redirect_to new_business_travel_merchant_path if !@merchant
  end
end
