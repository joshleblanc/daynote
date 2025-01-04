import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static values = { selectedRange: Array }

    connect() {
        console.log("Connected", this.selectedRangeValue);
        if(this.selectedRangeValue) {
            this.element.editor.setSelectedRange(this.selectedRangeValue)
        }
    }

    selectionChange() {
        this.selectedRangeValue = this.element.editor.getSelectedRange();
    }
}
