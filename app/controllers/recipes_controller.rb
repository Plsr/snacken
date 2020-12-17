class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def new
    @recipe = Recipe.new
    @recipe.recipe_ingredients.build.build_ingredient
  end

  def show
    @recipe = Recipe.find(params[:id])
    raise ActionController::RoutingError.new('Not Found') unless recipe_accessible?
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe created'
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      if recipe_in_active_meal_plan(@recipe.id)
        current_meal_plan.shopping_list.regenerate_ingredients!
      end
      redirect_to recipes_path, notice: 'Recipe updated'
    else
      render :edit
    end
  end

  private

  def current_meal_plan
    @current_meal_plan ||= current_user.meal_plans.most_recent
  end

  def recipe_in_active_meal_plan(recipe_id)
    active_recipes = current_meal_plan.recipes.pluck(:id)
    active_recipes.include?(recipe_id)
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :recipe_ingredients_attributes => [:id, :amount, :unit, :_destroy, :ingredient_attributes => [:name]])
  end

  def recipe_accessible?
    @recipe.user == current_user
  end
end
