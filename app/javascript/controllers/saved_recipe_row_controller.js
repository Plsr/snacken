import { Controller } from "stimulus";

export default class extends Controller {
  markForDelete(event) {
    const row = event.currentTarget.parentNode
    const input = row.querySelector("input[type='hidden']")
    input.value = true
    row.style.display = 'none'
  }
}
