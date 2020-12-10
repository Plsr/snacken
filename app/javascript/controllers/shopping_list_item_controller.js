import { Controller } from "stimulus"
import Rails from '@rails/ujs'

export default class extends Controller {
  toggle(event) {
    const id = event.target.dataset.id
    Rails.ajax({
      type: "post",
      url: `/toggle_checked_off/${id}`,
    })
  }
}
