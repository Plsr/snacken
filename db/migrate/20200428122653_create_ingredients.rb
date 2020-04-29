class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|

      t.timestamps
      t.string :name, null: false
      t.string :unit, null: false
    end
  end
end
