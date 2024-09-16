import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["message"]

  connect() {
    setTimeout(() => {
      this.remove()
    }, 3000)
  }

  remove() {
    this.messageTarget.classList.add("opacity-0", "transition-opacity", "duration-300")
    setTimeout(() => {
      this.element.remove()
    }, 300)
  }
}