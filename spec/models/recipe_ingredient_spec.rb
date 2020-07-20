require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  let(:recipe) { FactoryBot.create(:recipe) }
  let(:ingredient) { Ingredient.new(name: 'Cucumber') }
  describe '#unit_is_valid' do
    it 'is valid with a valid unit' do
      recipe_ingredient = RecipeIngredient.new(recipe: recipe, ingredient: ingredient, amount: 12, unit: RecipeIngredient::ALLOWED_UNITS.first)
      expect(recipe_ingredient.valid?).to be true
    end

    it 'is not valid with an invalid unit' do
      recipe_ingredient = RecipeIngredient.new(recipe: recipe, ingredient: ingredient, amount: 12, unit: 'km')
      expect(recipe_ingredient.valid?).to be false
    end
  end
end
