class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  accepts_nested_attributes_for :ingredients

  validates_presence_of :name
end
