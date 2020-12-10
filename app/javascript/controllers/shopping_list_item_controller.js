import { Controller } from "stimulus"
import Rails from '@rails/ujs'

export default class extends Controller {
  static targets = ['itemList']

  toggle(event) {
    console.log(event)
    event.preventDefault()
    event.stopPropagation()
    const id = event.currentTarget.dataset.id
    const target = event.currentTarget

    let checkbox
    if (event.target instanceof HTMLInputElement) {
      checkbox = event.target
    } else {
      checkbox = target.querySelector('input')
    }

    const wasCheckedOff = checkbox.checked


    Rails.ajax({
      type: "post",
      url: `/toggle_checked_off/${id}`,
    })



    checkbox.checked = !checkbox.checked
    this.itemListTarget.removeChild(target)
    if (wasCheckedOff) {
      this.itemListTarget.prepend(target)
    } else {
      this.itemListTarget.appendChild(target)
    }
  }
}
