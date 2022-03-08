class BetaCandidatesMailer < ApplicationMailer
  def candidates_confirmation_mailer(candidate)
    @candidate = candidate
    @url = confirm_beta_candidates_url(token: @candidate.confirmation_token)

    attachments.inline["logo.png"] = File.read("#{Rails.root}/app/assets/images/logo.png")

    mail to: @candidate.email, subject: 'Welcome to Dishbot Beta', from: 'noreply@dishbot.app'
  end
end
