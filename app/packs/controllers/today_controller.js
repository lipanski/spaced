import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "answer", "gradeLink" ]

  showAnswer(event) {
    event.preventDefault()
    event.currentTarget.classList.add("hidden")
    this.answerTarget.classList.remove("hidden")
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

