class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_needed_email.subject
  #
  def activation_needed_email(user)
    @user = user
    @url = activate_user_url(@user.activation_token)
    attachments.inline["logo.png"] = File.read("#{Rails.root}/app/assets/images/logo.png")

    mail to: user.email, subject: 'Welcome to Dishbot', from: 'noreply@dishbot.app'
  end

  # No need to send another email
  def activation_success_email(user)
    return
  end
end
