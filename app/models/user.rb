class User < ApplicationRecord
  authenticates_with_sorcery!
  attr_accessor :invite_code

  has_many :recipes
  has_many :meal_plans
  has_one  :beta_candidate

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true
  validates :invite_code, presence: true, on: :create
  validate :invite_code_valid, on: :create

  after_create :invalidate_invite_code

  def invite_code_valid
    code = InviteCode.unused.find_by(code: invite_code)
    unless code
      errors.add(:invite_code, 'is not valid')
    end
  end

  def invalidate_invite_code
    InviteCode.unused.find_by(code: invite_code).invalidate!
  end

  def activated?
    activation_state == 'active'
  end

  def current_meal_plan
    meal_plans.most_recent
  end

  def current_shopping_list
    current_meal_plan.shopping_list
  end
end
