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
  end
end
