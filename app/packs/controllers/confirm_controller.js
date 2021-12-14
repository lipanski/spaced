import { Controller } from "stimulus"

export default class extends Controller {
  static values = { message: String }

  connect() {
    this.element.addEventListener("click", (event) => {
      if (!(window.confirm(this.messageValue))) {
        event.preventDefault()
        event.stopImmediatePropagation()
      }
    })
  }
}
