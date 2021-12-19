import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "answer" ]

  showAnswer(event) {
    event.preventDefault()
    event.currentTarget.classList.add("hidden")
    this.answerTarget.classList.remove("hidden")
  }
}

