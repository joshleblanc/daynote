import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const time = this.element.textContent;
    const date = new Date(time);
    this.element.textContent = date.toLocaleString();
  }
}
