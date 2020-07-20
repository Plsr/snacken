class RecipeIngredient < ApplicationRecord
  attr_reader :units
  belongs_to :ingredient
  belongs_to :recipe

  accepts_nested_attributes_for :ingredient

  validates_presence_of :ingredient
  validates_presence_of :recipe
  validates_presence_of :amount
  validates_presence_of :unit
  validate :unit_is_valid

  ALLOWED_UNITS = ['ml' ,'l', 'g', 'mg', 'pcs', 'pckgs', 'tsp', 'tbsp']

  def ingredient_name
    ingredient.name
  end

  def ingredient_attributes=(attributes)
    self.ingredient = Ingredient.find_or_create_by(name: attributes[:name])
  end

  def unit_is_valid
    unless unit.in?(ALLOWED_UNITS)
      errors.add(:unit, 'Invalid unit')
    end
  end

  def units
    ALLOWED_UNITS
  end
end
