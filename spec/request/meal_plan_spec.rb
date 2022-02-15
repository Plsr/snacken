require "rails_helper"

RSpec.describe "MealPlan requests", type: :request do
  let!(:user) { FactoryBot.create(:user) }

  before(:each) do
    user.activate!
    login_user(user, 'Test1234')
  end

  describe "#index" do
    subject { get new_meal_plan_path }

    it "renders new if no uncommited meal plans pending" do
      expect(subject).not_to have_http_status(:redirect)
    end

    it "redirects to show if uncommitted meal plan present" do
      meal_plan = FactoryBot.create(:meal_plan, user: user)
      expect(subject).to redirect_to(meal_plan_path(meal_plan))
    end
  end

  describe "#create" do
    let!(:meal_plan) { FactoryBot.build(:meal_plan) }
    subject { post meal_plans_path(meal_plan: meal_plan.attributes) }

    it "redirects to recipes_path if user has no recipes" do
      expect(subject).to redirect_to(recipes_path)
    end

    context ":proposal param set" do
      subject { post meal_plans_path(meal_plan: meal_plan.attributes, proposal: true) }
      before do
        FactoryBot.create_list(:recipe, 10, user: user)
      end

      it "does create an uncommited MealPlan" do
        expect { subject }.to change { MealPlan.count }.by(1)
        expect(MealPlan.last.committed).to be false
      end

      it "does not create a shopping list" do
        subject
        expect(MealPlan.last.shopping_list).to be_nil
      end

      it "creates a commited meal plan if number of meals equals users recipes" do
        meal_plan.number_of_meals = user.recipes.count
        
        expect{ subject }.to change { MealPlan.count }.by(1)
        expect(MealPlan.last.committed).to be true
        expect(MealPlan.last.shopping_list.present?).to be true
      end

      it "redirects to #show" do
        expect(subject).to redirect_to meal_plan_path(MealPlan.last.id)
      end
    end

    context ":proposal param not set" do
      subject { post meal_plans_path(meal_plan: meal_plan.attributes) }
      before do
        FactoryBot.create_list(:recipe, 10, user: user)
      end

      it "does create an commited MealPlan" do
        expect { subject }.to change { MealPlan.count }.by(1)
        expect(MealPlan.last.committed).to be true
      end

      it "creates a shopping list" do
        subject
        expect(MealPlan.last.shopping_list.present?).to be true
      end

      it "redirects to show" do
        expect(subject).to redirect_to meal_plan_path(MealPlan.last.id)
      end
    end

  end
end
