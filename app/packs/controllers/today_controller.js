import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "answer", "grade" ]

  showAnswer(event) {
    event.preventDefault()
    event.currentTarget.classList.add("hidden")
    this.answerTarget.classList.remove("hidden")
    this.gradeTargets.forEach(function(grade) {
      grade.removeAttribute("disabled")
    })
  }
}

