require 'rails_helper'

RSpec.describe ShoppingList, type: :model do
  describe "#build_from_meal_plan" do
    let(:meal_plan) { FactoryBot.create(:meal_plan) }
    let(:user) { FactoryBot.create(:user) }

    it "builds a valid shopping list" do
      shopping_list = ShoppingList.build_from_meal_plan(meal_plan, user)
      expect(shopping_list.valid?).to be true
    end
    
    it "adds all the ingredients from the recipe to the shopping list" do
      shopping_list = ShoppingList.build_from_meal_plan(meal_plan, user)
      shopping_list.save
      recipe_ingredients = meal_plan.recipes.map{ |rec| rec.recipe_ingredients }.flatten
      expect(shopping_list.shopping_list_ingredients.count).to eql(recipe_ingredients.count)
    end

    it "converts the unit&amount from recipe to string" do
      shopping_list = ShoppingList.build_from_meal_plan(meal_plan, user)
      shopping_list.save

      ingr = meal_plan.recipes.first.recipe_ingredients.first
      expected_string = "#{ingr.amount} #{ingr.unit}"
      ingr_in_shopping_list = shopping_list.shopping_list_ingredients.find_by(ingredient_id: ingr.id)

      expect(ingr_in_shopping_list.amount).to eql(expected_string)
    end
  end
end
