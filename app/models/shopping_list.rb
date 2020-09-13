class ShoppingList < ApplicationRecord
  belongs_to :meal_plan
  belongs_to :user
  has_many :shopping_list_ingredients

  def self.build_from_meal_plan(meal_plan, user)
    recipe_ingredients = meal_plan.recipes.map { |rec| rec.recipe_ingredients }.flatten
    shopping_list_ingredients = recipe_ingredients.map do |ingr|
      ShoppingListIngredient.new(ingredient: ingr.ingredient, amount: ingr.amount, unit: ingr.unit)
    end

    shopping_list = ShoppingList.new(
      user: user, 
      meal_plan: meal_plan,
    )

    shopping_list.shopping_list_ingredients << shopping_list_ingredients
  end
end
