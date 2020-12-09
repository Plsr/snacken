class ConvertShoplistAmountToArray < ActiveRecord::Migration[6.0]
  def change
    remove_column :shopping_list_ingredients, :amount
    add_column :shopping_list_ingredients, :amount, :string, array: true, default: []
  end
end
