import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static values = {
      content: String
    }
  connect() {
    tippy(this.element, {
      content: this.contentValue,
      placement: "top",
      theme: "light",
      arrow: false,
      interactive: true,
      appendTo: document.body,
    })
  }
}
