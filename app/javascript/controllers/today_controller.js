import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "answer", "gradeLink" ]

  showAnswer(event) {
    event.preventDefault()
    event.currentTarget.classList.add("is-hidden")
    this.answerTarget.classList.remove("is-hidden")
    this.gradeLinkTargets.forEach(function(gradeLink) {
      gradeLink.removeAttribute("disabled")
    })
  }

  rateAnswer(event) {
    if (event.currentTarget.hasAttribute("disabled")) {
      event.preventDefault()
      event.stopImmediatePropagation()
    }
  }
}

