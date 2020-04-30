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
    wrapperDiv.setAttribute('class', 'flex flex-grow')
    wrapperDiv.innerHTML = `
      <div class="field mb-6 mr-3">
        <label for="recipe_recipe_ingredients_attributes_${this.currentRowCount}_ingredient_attributes_name" class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2">Name</label>
        <input type="text" name="recipe[recipe_ingredients_attributes][${this.currentRowCount}][ingredient_attributes][name]" id="recipe_recipe_ingredients_attributes_${this.currentRowCount}_ingredient_attributes_name" class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500">
      </div>
      <div class="field mb-6 mr-3">
        <label for="recipe_recipe_ingredients_attributes_${this.currentRowCount}_amount" class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2">Amount</label>
        <input type="text" name="recipe[recipe_ingredients_attributes][${this.currentRowCount}][amount]" id="recipe_recipe_ingredients_attributes_${this.currentRowCount}_amount" class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500">
      </div>
      <div class="field mb-6">
        <label for="recipe_recipe_ingredients_attributes_${this.currentRowCount}_ingredient_attributes_unit" class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2">Unit</label>
        <input type="text" name="recipe[recipe_ingredients_attributes][${this.currentRowCount}][ingredient_attributes][unit]" id="recipe_recipe_ingredients_attributes_${this.currentRowCount}_ingredient_attributes_unit" class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500">
      </div>
  `

    this.containerTarget.appendChild(wrapperDiv)
  }
}
