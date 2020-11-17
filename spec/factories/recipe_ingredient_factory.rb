FactoryBot.define do
  factory :recipe_ingredient do
    recipe
    ingredient

    unit { RecipeIngredient::ALLOWED_UNITS.sample }
    amount { rand(500) }

  end
end
