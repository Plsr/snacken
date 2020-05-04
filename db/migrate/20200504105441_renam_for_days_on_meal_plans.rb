class RenamForDaysOnMealPlans < ActiveRecord::Migration[6.0]
  def change
    remove_column :meal_plans, :for_days, :integer
    add_column :meal_plans, :number_of_meals, :integer
  end
end
