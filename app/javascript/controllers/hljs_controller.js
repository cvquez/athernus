import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="hljs"
export default class extends Controller {
    connect() {
        this.highlightedElement = this.element.tagName === "CODE" ? this.element : this.element.querySelector("code");
        if (this.highlightedElement && !this.highlightedElement.dataset.highlighted)
            HLJS.highlightElement(this.highlightedElement);
    }

    disconnect() {
        // this.highlightedElement.dataset.highlighted = null;
    }
}
