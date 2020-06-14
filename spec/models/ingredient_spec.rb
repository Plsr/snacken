require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe '#unit_is_valid' do
    it 'is valid with a valid unit' do
      ingredient = Ingredient.new(name: 'Cucumber', unit: Ingredient::ALLOWED_UNITS.first)
      expect(ingredient.valid?).to be true
    end

    it 'is not valid with an invalid unit' do
      ingredient = Ingredient.new(name: 'Cucumber', unit: 'km')
      expect(ingredient.valid?).to be false
    end
  end
end
