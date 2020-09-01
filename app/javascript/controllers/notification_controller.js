import { Controller } from "stimulus"

export default class extends Controller {
  hide(event) {
    this.element.parentNode.removeChild(this.element)
  }
}
