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
      ingr_in_shopping_list = shopping_list.shopping_list_ingredients.find_by(ingredient_id: ingr.ingredient.id)

      expect(ingr_in_shopping_list.amount.first).to eql(expected_string)
    end

    describe "groups to recipe ingredients if they are the same" do
      before(:each) do
        @dup_recipe = FactoryBot.create(:recipe)
        @meal_plan = FactoryBot.create(:meal_plan) 
        @dup_ingr = @meal_plan.recipes.first.recipe_ingredients.first
        @last_recipe = @meal_plan.recipes.last
        @added_amount = 200
      end

      it "adds the amounts if the unit is the same" do
        RecipeIngredient.create(
          ingredient: @dup_ingr.ingredient,
          recipe: @last_recipe,
          amount: @added_amount,
          unit: @dup_ingr.unit
        )

        shopping_list = ShoppingList.build_from_meal_plan(@meal_plan, user)
        shopping_list.save
        
        @meal_plan.reload

        shopping_list_item = shopping_list.shopping_list_ingredients.find_by(ingredient_id: @dup_ingr.ingredient.id)
        
        expect(shopping_list_item.amount.length).to eql(1)
        expect(shopping_list_item.amount.first).to eql("#{@dup_ingr.amount + @added_amount} #{@dup_ingr.unit}")
      end

      it "lists both amounts and units if the unit differs" do
        available_units = RecipeIngredient::ALLOWED_UNITS.dup
        available_units.delete(@dup_ingr.unit)
        new_unit = available_units.shuffle.first
        RecipeIngredient.create!(
          ingredient: @dup_ingr.ingredient,
          recipe: @last_recipe,
          amount: @added_amount,
          unit: new_unit
        )
        

        shopping_list = ShoppingList.build_from_meal_plan(@meal_plan, user)
        shopping_list.save
        
        @meal_plan.reload

        shopping_list_item = shopping_list.shopping_list_ingredients.find_by(ingredient_id: @dup_ingr.ingredient.id)

        expect(shopping_list_item.amount.length).to eql(2)
        expect(shopping_list_item.amount.first).to eql("#{@dup_ingr.amount} #{@dup_ingr.unit}")
        expect(shopping_list_item.amount.last).to eql("#{@added_amount} #{new_unit}")
      end
    end
  end

  describe '#regenerate_ingredients!' do
    let(:meal_plan) { FactoryBot.create(:meal_plan) }
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      @shopping_list = ShoppingList.build_from_meal_plan(meal_plan, user)
      @shopping_list.save!
      @deleted_ingredient_ids = meal_plan.recipes.first.recipe_ingredients.pluck(:ingredient_id)

      meal_plan.recipes.delete(meal_plan.recipes.first.id)
    end

    it 'updates the ingredients accordingly' do
      @shopping_list.regenerate_ingredients!
      expect(@shopping_list.shopping_list_ingredients.pluck(:ingredient_id)).not_to include(@deleted_ingredient_ids)
    end

    it 'deletes the unused record from the database' do
      @shopping_list.regenerate_ingredients!

      expect(ShoppingListIngredient.find_by(ingredient_id: @deleted_ingredient_ids.first)).to be_falsy
    end
  end
end
