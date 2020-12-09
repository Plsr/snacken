class ShoppingList < ApplicationRecord
  belongs_to :meal_plan
  belongs_to :user
  has_many :shopping_list_ingredients

  def self.build_from_meal_plan(meal_plan, user)
    recipe_ingredients = meal_plan.recipes.map { |rec| rec.recipe_ingredients }.flatten
    
    # Group all ingredients by id
    # The amount should just be a string
    # If the unit is the same, add the two amounts
    # If the unit differs, just save "amount[unit] + amount[unitY]"
    shopping_list_ingredients = recipe_ingredients.map do |ingr|
      {ingredient: ingr.ingredient, amount: "#{ingr.amount} #{ingr.unit}"}
    end

    shopping_list = ShoppingList.new(
      user: user, 
      meal_plan: meal_plan,
    )

    shopping_list.shopping_list_ingredients.build(shopping_list_ingredients)
    shopping_list
  end
end
