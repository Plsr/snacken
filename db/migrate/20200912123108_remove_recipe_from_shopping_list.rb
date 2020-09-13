class RemoveRecipeFromShoppingList < ActiveRecord::Migration[6.0]
  def change
    remove_reference :shopping_lists, :recipe, index:true, foreign_key: true
  end
end
