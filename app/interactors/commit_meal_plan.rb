class CommitMealPlan
  include Interactor

  delegate :params, :proposal, :user,  to: :context

  def call
    @meal_plan = MealPlan.new(params)
    @meal_plan.user = user
    needed_recipes = params[:number_of_meals].to_i
    @meal_plan.recipes << get_recipes

    if !proposal
      commit_meal_plan
    end

    if needed_recipes == user.recipes.count
     commit_meal_plan
    end

    if @meal_plan.save
      context.meal_plan = @meal_plan
      context.shopping_list = @shopping_list
    else 
      context.fail!
    end
  end

  private

  def commit_meal_plan
    @meal_plan.committed = true
    @shopping_list = ShoppingList.build_from_meal_plan(@meal_plan, user)
  end

  def get_recipes 
    user.recipes.ordered_random.limit(@meal_plan.number_of_meals)
  end
end