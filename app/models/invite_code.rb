class InviteCode < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  before_validation :set_code

  scope :unused, -> { where(used_at: nil) }

  def set_code
    return if !code.blank?
    self.code = SecureRandom.alphanumeric(15)
  end

  def invalidate!
    update_attribute(:used_at, Time.now) 
  end
end
