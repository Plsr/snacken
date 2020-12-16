class MealPlansController < ApplicationController
  def new
    @meal_plan = MealPlan.new(number_of_meals: 2)
  end

  def index
    @meal_plans = current_user.meal_plans.order(created_at: :desc)
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

  def update_with_shopping_list
    @meal_plan = MealPlan.find(params[:id])
    @shopping_list = ShoppingList.build_from_meal_plan(@meal_plan, current_user)

    if @shopping_list.save
      redirect_to meal_plan_path(@meal_plan)
    else
      # TODO: Pass error message
      redirect_to meal_plan_path(@meal_plan)
    end
  end

  def swap_recipe
    @meal_plan = MealPlan.find(params[:id])
    raise ActionController::RoutingError.new('Not Found') unless meal_plan_accessible?
    return unless @meal_plan.recipes_changable

    recipe_ids = @meal_plan.recipe_ids

    new_recipe_id = Recipe.where.not(id: recipe_ids).order("RANDOM()").first.id

    recipe_ids.delete(params[:recipe_id].to_i)
    recipe_ids.push(new_recipe_id)

    if @meal_plan.update(recipe_ids: recipe_ids)
      redirect_to meal_plan_path(@meal_plan), notice: 'Changed recipe'
    else
      flash.now[:alert] = 'Login failed'
      render :show
    end
  end

  def show
    @meal_plan = current_user.meal_plans.find(params[:id])
    if @meal_plan.shopping_list.present?
      @shopping_list_ingredients = @meal_plan.shopping_list.shopping_list_ingredients.checked_off_last
    end
  end

  private

  def meal_plan_accessible?
    @meal_plan.user == current_user
  end

  def meal_plan_params
    params.require(:meal_plan).permit(:number_of_meals)
  end
end
