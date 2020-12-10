class ShoppingListsController < ApplicationController
  def toggle_ingredient_checked_off
    shplst_ingredient = ShoppingListIngredient.find(params[:id])
    newState = shplst_ingredient.checked_off? ? nil : Time.now
    shplst_ingredient.update_attribute(:checked_off_at, newState)
  end
end
