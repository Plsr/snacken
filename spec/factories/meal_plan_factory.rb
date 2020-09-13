FactoryBot.define do
  factory :meal_plan do
    user

    transient do
      recipe_count { 5 }
    end

    number_of_meals { recipe_count }

    after(:create) do |meal_plan, evaluator|
      create_list(:recipe, evaluator.recipe_count, meal_plans: [meal_plan])

      meal_plan.reload
    end
  end
end
