class Ingredient < ApplicationRecord
  attr_reader :units
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates_presence_of :name
  validates_presence_of :unit
  validates_uniqueness_of :name

  validate :unit_is_valid

  ALLOWED_UNITS = ['ml' ,'l', 'g', 'mg', 'pcs', 'pckgs', 'tsp', 'tbsp']

  def unit_is_valid
    unless unit.in?(ALLOWED_UNITS)
      errors.add(:unit, 'Invalid unit')
    end
  end

  def units
    ALLOWED_UNITS
  end
end
