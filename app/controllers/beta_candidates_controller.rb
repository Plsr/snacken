# frozen_string_literal: true

class BetaCandidatesController < ApplicationController
  skip_before_action :require_login, only: [:create, :confirm]

  def create
    @beta_candidate = BetaCandidate.new(beta_candidate_params)

    if @beta_candidate.save
      BetaCandidatesMailer.candidates_confirmation_mailer(@beta_candidate).deliver_later
      redirect_to root_path, notice: 'Your email has sucessfully been entered!'
    else
      redirect_to root_path, alert: "We're sorry, something went wrong"
    end
  end

  def confirm
    token = params[:token]
    candidate = BetaCandidate.unconfirmed.find_by(confirmation_token: token)

    if candidate
      candidate.update(confirmed_at: DateTime.now)
      @state = 'success'
    else
      @state = 'failure'
    end
  end

  private

  def beta_candidate_params
    params.require(:beta_candidate).permit(:email)
  end
end
