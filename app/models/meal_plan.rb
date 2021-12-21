class MealPlan < ApplicationRecord
  belongs_to :user
  has_one :shopping_list
  has_and_belongs_to_many :recipes

  scope :most_recent, -> { order('created_at DESC').first }

  # TODO: Use activeflag for this
  def committed?
    shopping_list.present?
  end

  def recipes_changable
    enough_recipes? && !shopping_list.present?
  end

  def enough_recipes?
    user.recipes.count > recipes.count
  end
end
