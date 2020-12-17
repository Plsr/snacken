import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["row", "container"];

  connect() {
    if (this.hasRowTarget) {
      this.currentRowCount = this.rowTargets.length - 1;
    }
  }

  // TODO: Pass select options through data field so that we don't
  // have to update this file every time the backend changes.
  // TODO: Clean up, this is ugly and error-prone.
  addRow(event) {
    event.preventDefault();
    this.currentRowCount++;

    const wrapperDiv = document.createElement("div");
    wrapperDiv.setAttribute(
      "data-target",
      "recipe-rows.row unsaved-recipe-row.row"
    );
    wrapperDiv.setAttribute("data-controller", "unsaved-recipe-row");
    wrapperDiv.setAttribute("class", "flex flex-grow");
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
              <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="recipe_recipe_ingredients_attributes_${this.currentRowCount}_unit">Unit</label>
              <select class="appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" name="recipe[recipe_ingredients_attributes][${this.currentRowCount}][unit]" id="recipe_recipe_ingredients_attributes_${this.currentRowCount}_unit"><option value="ml">ml</option>
<option value="l">l</option>
<option value="g">g</option>
<option value="mg">mg</option>
<option value="pcs">pcs</option>
<option value="pckgs">pckgs</option>
<option value="tsp">tsp</option>
<option value="tbsp">tbsp</option></select>
            </div>
            <div data-action="click->unsaved-recipe-row#remove">Remove</div>
  `;

    this.containerTarget.appendChild(wrapperDiv);
  }
}
