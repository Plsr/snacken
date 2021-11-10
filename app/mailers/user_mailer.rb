class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_needed_email.subject
  #
  def activation_needed_email(user)
    @user = user
    @url = activate_user_url(@user.activation_token)

    mail to: user.email, subject: 'Welcome to Snacken'
  end

  # No need to send another email
  def activation_success_email(user)
    return
  end
end
