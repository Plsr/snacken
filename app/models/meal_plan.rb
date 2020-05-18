class MealPlan < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :recipes

  def recipes_changable
    user.recipes.count > recipes.count
  end
end
