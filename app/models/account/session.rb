class Account::Session < ActiveRecord::Base
  belongs_to :user
  
  attr_accessor :name, :password
  
  def logout
    return if self.expired_at
    
    self.expired_at = Time.now
    self.save
  end
end
