class Mailer < ActionMailer::Base
  default from: %{"极旅" <#{Rails.application.config.action_mailer.smtp_settings[:from]}>}, content_type: 'text/html'

  def standard_mail(options = {})
    mail(options) do |format|
      format.html do
        render text: options[:body]
      end
    end
  end

  def self.mail(options = {})
    return if options[:to].blank?
    self.standard_mail(options).deliver
  end
end
