FactoryBot.define do
  factory :recipe do
    name { "My reciple" }
    user

    transient do
      ingredient_count { 3 }
    end

    after(:create) do |recipe, evaluator|
      create_list(
        :recipe_ingredient,
        evaluator.ingredient_count,
        recipe: recipe
      )
    end
  end
end
