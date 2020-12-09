class ShoppingList < ApplicationRecord
  belongs_to :meal_plan
  belongs_to :user
  has_many :shopping_list_ingredients

  # TODO: Refactor in smaller chunks
  def self.build_from_meal_plan(meal_plan, user)
    recipe_ingredients = meal_plan.recipes.map { |rec| rec.recipe_ingredients }.flatten
    
    # Group ingredients by id
    grouped_ingredients = recipe_ingredients.group_by{ |i| i.ingredient.id }
    shopping_list_ingredients = []

    # Loop over each value (i.e. each ingredient group)
    grouped_ingredients.each_value do |ingredient_group|
      ingredient = ingredient_group.first.ingredient

      # Same ingredient is present more than once
      if ingredient_group.length > 1 
        # Group ingredients by unit
        grouped_by_units = ingredient_group.group_by{ |i| i.unit }

        # Placeholder to store amount strings in
        amount = []

        # Loop over every single unit group
        grouped_by_units.each do |unit, ingredients| 
            
          # Sum up all the values for the current unit
          total_amount = ingredients.map { |i| i.amount }.reduce(0, :+)

          # return one string
          amount << "#{total_amount} #{unit}"
        end
      # Same ingredient is only present once
      else
        amount = ["#{ingredient_group.first.amount} #{ingredient_group.first.unit}"]
      end
       

      shopping_list_ingredients << { ingredient: ingredient, amount: amount }
    end

    shopping_list = ShoppingList.new(
      user: user, 
      meal_plan: meal_plan,
    )

    shopping_list.shopping_list_ingredients.build(shopping_list_ingredients)
    shopping_list
  end
end
