import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "menu" ]

  showMenu(event) {
    event.currentTarget.classList.toggle("is-active")
    this.menuTarget.classList.toggle("is-active")
  }
}
