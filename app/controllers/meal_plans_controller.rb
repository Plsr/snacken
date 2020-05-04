class MealPlansController < ApplicationController
  def new
    @meal_plan = MealPlan.new(number_of_meals: 2)
  end

  def create
    @meal_plan = MealPlan.new(meal_plan_params)
    @meal_plan.user = current_user
    needed_recipes = @meal_plan.number_of_meals
    recipes = Recipe.ordered_random.limit(needed_recipes)
    @meal_plan.recipes << recipes

    if @meal_plan.save
      redirect_to meal_plan_path(@meal_plan)
    else
      render :new
    end
  end

  def show
    @meal_plan = current_user.meal_plans.find(params[:id])
  end

  private

  def meal_plan_params
    params.require(:meal_plan).permit(:number_of_meals)
  end
end
