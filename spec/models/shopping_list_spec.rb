require 'rails_helper'

RSpec.describe ShoppingList, type: :model do
  describe "#build_from_meal_plan" do
    let(:meal_plan) { FactoryBot.create(:meal_plan) }
    let(:user) { FactoryBot.create(:user) }
    it "builds a valid shopping list" do
      shopping_list = ShoppingList.build_from_meal_plan(meal_plan, user)
      expect(user.valid?).to be true
    end
  end
end
