import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'amount', 'price', 'priceTotal' ]

  connect() {
  }

  setAmount() {
    this.calculate()
  }

  calculate() {
    this.priceTotalTarget.value = this.amountTarget.value * this.priceTarget.value;

    this.priceTotalTarget.dispatchEvent(new Event('click', { bubbles: true, cancelable: false}))
  }
}
