class MealPlansController < ApplicationController
  def new
    if current_user.meal_plans.uncommitted.any?
      flash[:notice] = "You have an uncommitted meal plan lying around"
      redirect_to meal_plan_path(current_user.meal_plans.uncommitted.first)
    else
      @meal_plan = MealPlan.new(number_of_meals: 2)
    end
  end

  def index
    @meal_plans = current_user.meal_plans.order(created_at: :desc)
  end

  def create
    # TODO: Move guard claused to pundit
    needed_recipes = meal_plan_params[:number_of_meals]
    redirect_to recipes_path and return if current_user.recipes.none?
    redirect_to recipes_path and return if needed_recipes.to_i > current_user.recipes.count

    result = CommitMealPlan.call(params: meal_plan_params, proposal: params[:proposal].present?, user: current_user)
    if result.success?
      @meal_plan = result.meal_plan
      @shopping_list = result.shopping_list
      redirect_to meal_plan_path(@meal_plan)
    else
      flash[:notice] = "Something went wrong"
      render :new
    end
  end

  def update_with_shopping_list
    @meal_plan = MealPlan.find(params[:id])
    @shopping_list = ShoppingList.build_from_meal_plan(@meal_plan, current_user)

    if @shopping_list.save
      @meal_plan.update(committed: true)
      redirect_to meal_plan_path(@meal_plan)
    else
      # TODO: Pass error message
      redirect_to meal_plan_path(@meal_plan)
    end
  end

  def swap_recipe
    @meal_plan = MealPlan.find(params[:id])
    raise ActionController::RoutingError.new('Not Found') unless meal_plan_accessible?
    return unless @meal_plan.recipes_changable?

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

  def share_to_things
    meal_plan = current_user.meal_plans.find(params[:id])
    date = meal_plan.created_at.strftime("%d.%m.%Y")
    render json: ThingsJsonService.new(meal_plan.shopping_list, date).build_link
  end

  private

  def meal_plan_accessible?
    @meal_plan.user == current_user
  end

  def meal_plan_params
    params.require(:meal_plan).permit(:number_of_meals)
  end
end
