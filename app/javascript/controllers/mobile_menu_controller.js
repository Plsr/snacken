import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["menu", "menuButton"];

  toggleMenu(_event) {
    this.menuTarget.classList.toggle("hidden");

    let menuText = "Close Menu";

    if (this.menuTarget.classList.contains("hidden")) {
      menuText = "Show Menu";
    }

    this.menuButtonTarget.innerHTML = menuText;
  }
}
