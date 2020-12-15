class ShoppingListIngredientsService
  def initialize(recipes)
    @meal_plan_recipes = recipes
  end

  def create_ingredients
    grouped_ingredients = @meal_plan_recipes.group_by{ |i| i.ingredient.id }
    shopping_list_ingredients = []

    grouped_ingredients.each_value do |ingredient_group|
      ingredient = ingredient_group.first.ingredient
      amount = amounts_for(ingredient_group)

      shopping_list_ingredients << { ingredient: ingredient, amount: amount }
    end

    shopping_list_ingredients
  end

  private

  def amount_string_for(amount, unit)
    "#{amount} #{unit}"
  end

  def amounts_for(ingredient_group)
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
