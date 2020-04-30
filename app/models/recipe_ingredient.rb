class RecipeIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe

  accepts_nested_attributes_for :ingredient

  validates_presence_of :ingredient
  validates_presence_of :recipe
  validates_presence_of :amount

  def ingredient_name
    ingredient.name
  end

  def ingredient_unit
    ingredient.unit
  end

  def ingredient_attributes=(attributes)
    self.ingredient = Ingredient.find_or_create_by(name: attributes[:name]) do |ingredient|
      ingredient.unit = attributes[:unit]
    end
  end
end
