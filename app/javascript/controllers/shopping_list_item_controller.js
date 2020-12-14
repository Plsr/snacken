import { Controller } from "stimulus"
import Rails from '@rails/ujs'

export default class extends Controller {
  static targets = ['itemList']

  toggle(event) {
    event.preventDefault()
    event.stopPropagation()

    const id = event.currentTarget.dataset.id
    const target = event.currentTarget

    // Event can be triggered with click on the row or on the
    // checkbox directly. Based on that, we either us the original
    // event target or query for the checkbox manually.
    let checkbox
    if (event.target instanceof HTMLInputElement) {
      checkbox = event.target
    } else {
      checkbox = target.querySelector('input')
    }

    const wasCheckedOff = checkbox.checked

    // For now, just be optimistic and assume everything worked
    // without handling errors.
    // TODO: Error handling (@plsr, 14/12/2020)
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
