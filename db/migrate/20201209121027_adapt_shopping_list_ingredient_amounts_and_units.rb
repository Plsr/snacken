class AdaptShoppingListIngredientAmountsAndUnits < ActiveRecord::Migration[6.0]
  def change
    change_column :shopping_list_ingredients, :amount, :string
    remove_column :shopping_list_ingredients, :unit
  end
end
