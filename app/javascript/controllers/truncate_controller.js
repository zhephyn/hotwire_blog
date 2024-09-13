import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "link"]
  static values = { limit: Number }

  connect() {
    this.limitValue = this.limitValue || 100  // Default to 100 characters
    this.truncateText()
  }

  truncateText() {
    const fullText = this.contentTarget.dataset.fullText
    if (fullText.length > this.limitValue) {
      const truncated = fullText.slice(0, this.limitValue) + "..."
      this.contentTarget.textContent = truncated
      this.linkTarget.classList.remove("hidden")
    }
  }

  toggleText(event) {
    event.preventDefault()  // Prevent any default button behavior
    const fullText = this.contentTarget.dataset.fullText
    if (this.contentTarget.textContent.endsWith("...")) {
      this.contentTarget.textContent = fullText
      this.linkTarget.textContent = "Show less"
    } else {
      this.truncateText()
      this.linkTarget.textContent = "Show more"
    }
  }
}