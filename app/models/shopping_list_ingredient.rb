class ShoppingListIngredient < ApplicationRecord
  belongs_to :shopping_list
  belongs_to :ingredient

  validates_presence_of :ingredient
  validates_presence_of :amount

  def ingredient_name
    ingredient.name
  end

  def ingredient_attributes=(attributes)
    self.ingredient = Ingredient.find_or_create_by(name: attributes[:name])
  end

  def checked_off?
    !checked_off_at.blank?
  end
end
