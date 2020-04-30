class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_and_belongs_to_many :meal_plans
  accepts_nested_attributes_for :recipe_ingredients

  validates_presence_of :name
end
