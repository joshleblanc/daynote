import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["syncing", "synced", "form", "trix"]

  connect() {
    console.log("reconnected", this.selectedRange);
  }

  init() {
  }

  change(e) {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.syncingTarget.classList.remove('hidden')
      this.syncedTarget.classList.add('hidden')
      this.formTarget.requestSubmit()
    }, 1000)

  }
}
