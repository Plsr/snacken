# frozen_string_literal: true

class BetaCandidatesController < ApplicationController
  skip_before_action :require_login, only: [:create]

  def create
    @beta_candidate = BetaCandidate.new(beta_candidate_params)

    if @beta_candidate.save
      redirect_to root_path, notice: 'Your email has sucessfully been entered!'
    else
      redirect_to root_path, alert: "We're sorry, something went wrong"
    end
  end

  private

  def beta_candidate_params
    params.require(:beta_candidate).permit(:email)
  end
end
