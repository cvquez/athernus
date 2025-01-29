import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slug"
export default class extends Controller {
  static targets = ['slug'];

  generateSlug() {
    const randomSlug = this.generateRandomHex();
    this.slugTarget.value = randomSlug;
  }
  generateRandomHex(length = 20) {
    var result = '';
    var characters = '0123456789abcdef';
    var charactersLength = characters.length;
    for (var i = 0; i < length; i++) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
  }
}
