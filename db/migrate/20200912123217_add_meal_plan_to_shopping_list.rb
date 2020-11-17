class AddMealPlanToShoppingList < ActiveRecord::Migration[6.0]
  def change
    add_reference :shopping_lists, :meal_plan, null: false, foreign_key: true
  end
end
