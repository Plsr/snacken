class ShoppingList < ApplicationRecord
  belongs_to :meal_plan
  belongs_to :user
  has_many :shopping_list_ingredients

  def self.build_from_meal_plan(meal_plan, user)
    recipe_ingredients = meal_plan.recipes.map { |rec| rec.recipe_ingredients }.flatten
    shopping_list_ingredients = create_ingredients_from(recipe_ingredients)

    shopping_list = ShoppingList.new(
      user: user, 
      meal_plan: meal_plan,
    )

    shopping_list.shopping_list_ingredients.build(shopping_list_ingredients)
    shopping_list
  end

  private

  # TODO: All of the code below should probably live in a service class
  # at some point in the future (@plsr, 09/12/2020)
  def self.amount_string_for(amount, unit)
    "#{amount} #{unit}"
  end

  def self.create_ingredients_from(recipe_ingredients)
    grouped_ingredients = recipe_ingredients.group_by{ |i| i.ingredient.id }
    shopping_list_ingredients = []

    grouped_ingredients.each_value do |ingredient_group|
      ingredient = ingredient_group.first.ingredient
      amount = amounts_for(ingredient_group)

      shopping_list_ingredients << { ingredient: ingredient, amount: amount }
    end

    shopping_list_ingredients
  end

  def self.amounts_for(ingredient_group)
    if ingredient_group.length > 1 
      grouped_by_units = ingredient_group.group_by{ |i| i.unit }
      amount = []

      grouped_by_units.each do |unit, ingredients| 
        total_amount = ingredients.map { |i| i.amount }.reduce(0, :+)
        amount << amount_string_for(total_amount, unit)
      end
    else
      amount = [amount_string_for(ingredient_group.first.amount, ingredient_group.first.unit)]
    end

    amount
  end
end
