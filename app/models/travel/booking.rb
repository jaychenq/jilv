class Travel::Booking < ActiveRecord::Base
  belongs_to :user, class_name: Account::User
  belongs_to :merchant
  belongs_to :product
  belongs_to :journey
  belongs_to :inventory

  validates :user, :merchant, :product, :journey, :inventory, existence: true
  validates :adult_number, :child_number, :total_price, numericality: { only_integer: true }
  validates :started_on, :name, :phone, :country, :state, :city, :address, :postcode, presence: true
  
  default_scope { where(active: true) }
  
  cattr_accessor :admin_fields
  self.admin_fields = %w[]
  
  before_validation do
    self.product_id = self.journey.product.id
    self.merchant_id = self.product.merchant.id
    self.total_price = self.adult_number.to_i * self.journey.inventories.find_by(started_on: self.started_on).try(:adult_price).to_i + self.child_number.to_i * self.journey.inventories.find_by(started_on: self.started_on).try(:child_price).to_i
    true
  end
  
  def alipay_checkout_url
    options = {
      subject: "##{self.id}",#{self.product.try(:name)}
      body: "##{self.id}",
      out_trade_no: self.id,
      service: 'create_direct_pay_by_user',
      total_fee: self.total_price,
      show_url: 'http://www.jilvtrip.com/',
      return_url: "http://www.jilvtrip.com/travel/bookings/#{self.id}/alipay_return",
      notify_url: "http://www.jilvtrip.com/travel/bookings/#{self.id}/alipay_return?source=notify",
      payment_type: '1',
    }
    alipay_url(options)
  end

private

  def alipay_url(options)
    options.merge!({
      _input_charset: 'utf-8',
      partner: CONFIG.alipay.account,
      seller_email: CONFIG.alipay.email,
    })
    puts options.sort.map{|k,v|"#{k}=#{v}"}.join("&")+CONFIG.alipay.key
    options.merge!({
      sign_type: 'MD5',
      sign: Digest::MD5.hexdigest(options.sort.map{|k,v|"#{k}=#{v}"}.join("&")+CONFIG.alipay.key),
    })
    action = "https://mapi.alipay.com/gateway.do"
    cgi_escape_action_and_options(action, options)
  end
  
  def cgi_escape_action_and_options(action, options)
    "#{action}?#{options.sort.map{|k, v| "#{CGI::escape(k.to_s)}=#{CGI::escape(v.to_s)}" }.join('&')}"
  end
end
