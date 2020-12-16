class ShoppingList < ApplicationRecord
  belongs_to :meal_plan
  belongs_to :user
  has_many :shopping_list_ingredients

  def self.build_from_meal_plan(meal_plan, user)
    recipe_ingredients = meal_plan.recipes.map { |rec| rec.recipe_ingredients }.flatten
    # shopping_list_ingredients = create_ingredients_from(recipe_ingredients)
    shopping_list_ingredients = ShoppingListIngredientsService.new(recipe_ingredients).create_ingredients

    shopping_list = ShoppingList.new(
      user: user,
      meal_plan: meal_plan,
    )

    shopping_list.shopping_list_ingredients.build(shopping_list_ingredients)
    shopping_list
  end

  def regenerate_ingredients!
    recipe_ingredients = self.meal_plan.recipes.map { |rec| rec.recipe_ingredients }.flatten
    shopping_list_ingredients = ShoppingListIngredientsService.new(recipe_ingredients).create_ingredients
    self.shopping_list_ingredients.destroy_all
    self.shopping_list_ingredients.build(shopping_list_ingredients)
    self.save
  end
end
