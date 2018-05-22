import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'menu' ]

  initialize() {
  }

  connect() {
    this.showWhenNeeded();
  }

  showWhenNeeded() {
    if(this.data.get('show-popover') === 'true') {
      this.show();
    }
  }

  show() {
    $(this.menuTarget).popover('show')
  }

  hide() {
    this.menuTarget.popover('show')
  }
}
