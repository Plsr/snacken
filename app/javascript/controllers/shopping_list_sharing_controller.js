import { Controller } from 'stimulus'
import Rails from '@rails/ujs'

export default class extends Controller {
  things(event) {
    const id = event.currentTarget.dataset.mealPlanId
    Rails.ajax({
      type: "get",
      url: `/export_to_things/${id}`,
      dataType: 'text',
      success: (res) => window.open(res)
    })
  }
}
