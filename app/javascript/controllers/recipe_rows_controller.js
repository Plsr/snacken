import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['row', 'container']

  connect() {
    if (this.hasRowTarget) {
      this.currentRowCount = this.rowTargets.length - 1
    }
  }

  // TODO: Clean up
  addRow(event) {
    console.log('Registered Click')
    console.log(this.currentRowCount)
    event.preventDefault()
    this.currentRowCount++

    const wrapperDiv = document.createElement('div')
    wrapperDiv.setAttribute('data-target', 'recipe-rows.row')
    wrapperDiv.innerHTML = `<div class="field mb-6">
    <label for="recipe_recipe_ingredients_attributes_${this.currentRowCount}_ingredient_attributes_name">Name</label>
    <input type="text" name="recipe[recipe_ingredients_attributes][${this.currentRowCount}][ingredient_attributes][name]" id="recipe_recipe_ingredients_attributes_${this.currentRowCount}_ingredient_attributes_name">
  </div>
  <div class="field mb-6">
    <label for="recipe_recipe_ingredients_attributes_${this.currentRowCount}_amount">Amount</label>
    <input type="text" name="recipe[recipe_ingredients_attributes][${this.currentRowCount}][amount]" id="recipe_recipe_ingredients_attributes_${this.currentRowCount}_amount">
  </div>
  <div class="field mb-6">
    <label for="recipe_recipe_ingredients_attributes_${this.currentRowCount}_ingredient_attributes_unit">Unit</label>
    <input type="text" name="recipe[recipe_ingredients_attributes][${this.currentRowCount}][ingredient_attributes][unit]" id="recipe_recipe_ingredients_attributes_${this.currentRowCount}_ingredient_attributes_unit">
  </div>`

    this.containerTarget.appendChild(wrapperDiv)
  }
}
