import { Controller } from "stimulus";

// This controller only handles the removal of UNSAVED
// rows in the recipe form (i.e. rows that were added by the
// recipe rows controller)
export default class extends Controller {
  static targets = ["row"];

  remove(_event) {
    this.rowTarget.remove();
  }
}
