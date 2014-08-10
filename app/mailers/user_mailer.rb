class UserMailer < ActionMailer::Base
  default from: %{"环旅" <#{Rails.application.config.action_mailer.smtp_settings[:from]}>}, content_type: 'text/html'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.foget_pass.subject
  #
  def foget_pass(name,reset_token)
    @name = name
    @reset_token = reset_token
    mail to: name
  end
end
