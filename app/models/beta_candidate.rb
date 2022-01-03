class BetaCandidate < ApplicationRecord
  before_validation :create_confirmation_token

  belongs_to :user, optional: true

  validates :email, presence: true, uniqueness: true
  validates :confirmation_token, presence: true

  def converted?
    converted_at.present?
  end

  private

  def create_confirmation_token
    if self.confirmation_token.blank?
      self.confirmation_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
