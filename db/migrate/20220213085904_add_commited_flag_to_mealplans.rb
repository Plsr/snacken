class AddCommitedFlagToMealplans < ActiveRecord::Migration[6.1]
  def change
    add_column :meal_plans, :committed, :boolean, default: false
  end
end
