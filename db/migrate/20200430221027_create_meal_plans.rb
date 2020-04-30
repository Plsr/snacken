class CreateMealPlans < ActiveRecord::Migration[6.0]
  def change
    create_table :meal_plans do |t|
      t.integer :for_days
      t.references :user

      t.timestamps
    end

    create_table :meal_plans_recipes do |t|
      t.references :meal_plan
      t.references :recipe
    end
  end
end
