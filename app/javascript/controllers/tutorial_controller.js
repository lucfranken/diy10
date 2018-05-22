import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'menu' ]

  initialize() {
  }

  connect() {
    this.show();
  }

  show() {
    $(this.menuTarget).popover('show')
  }

  hide() {
    this.menuTarget.popover('show')
  }
}
