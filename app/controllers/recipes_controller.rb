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

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :recipe_ingredients_attributes => [:amount, :unit, :ingredient_attributes => [:name]])
  end

  def recipe_accessible?
    @recipe.user == current_user
  end
end
