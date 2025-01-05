import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static values = {
      content: String
    }

  connect() {
    // Check if this element is already wrapped
    if (this.element.parentElement?.classList.contains('insight-wrapper')) {
      return;
    }

    // Create the side indicator
    this.indicator = document.createElement('div');
    this.indicator.className = 'insight-indicator';
    this.indicator.innerHTML = '🤖';
    
    // Create a wrapper for positioning
    const wrapper = document.createElement('div');
    wrapper.className = 'insight-wrapper';
    wrapper.style.position = 'relative';
    wrapper.style.display = 'flex space-between';
    
    // Wrap the element's contents
    this.element.insertAdjacentElement('beforebegin', wrapper);
    wrapper.appendChild(this.element);
    wrapper.appendChild(this.indicator);

    // Initialize tippy on the indicator instead of the text
    tippy(this.element, {
      content: this.contentValue,
      placement: "top",
      theme: "light-border",
      interactive: true,
      animation: "shift-away",
      arrow: true,
      maxWidth: 350,
      hideOnClick: true,
      onShow(instance) {
        setTimeout(() => {
          instance.popperInstance.update();
        }, 0);
      }
    });

    // Add styles for the text
    this.element.style.cursor = "pointer";
    // Add hover effects for the indicator itself
    this.indicator.addEventListener('mouseenter', () => {
        this.onMouseEnter();
    });
    this.indicator.addEventListener('mouseleave', () => {
        this.onMouseLeave();
    });
  }

  onMouseEnter() {
    this.indicator.classList.add('insight-indicator-hover');
    this.element.style.backgroundColor = "rgba(16, 185, 129, 0.05)";
  }

  onMouseLeave() {
    this.indicator.classList.remove('insight-indicator-hover');
    this.element.style.backgroundColor = "transparent";
  }
}
