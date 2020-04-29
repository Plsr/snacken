class AddUsersToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_reference :recipes, :user, null: false, foreign_key: true
  end
end
