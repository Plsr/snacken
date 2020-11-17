class CreateShoppingListIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :shopping_list_ingredients do |t|
      t.references :shopping_list, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.string :unit
      t.integer :amount
      t.datetime :checked_off_at

      t.timestamps
    end
  end
end
