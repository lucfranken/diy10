import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'total', 'amount', 'price', 'container', 'submitContainer' ];

  connect(){
    this.calculateTotal();
    this.hideOrShowContainerWhenNeeded();
  }

  hideOrShowContainerWhenNeeded = () => {
    this.calculateTotal();
    console.log(this.totalTarget.value);
    if(!parseFloat(this.totalTarget.value)) {
      this.hideContent(this.containerTarget);
    }else{
      this.showContent(this.containerTarget);
    }
  }

  // Cannot work with the line totals because they may not be ready yet (async)
  calculateTotal() {
    let total = 0;
    this.amountTargets.map((element, index) => {
      const amount = parseFloat(element.value);
      const price = parseFloat(this.priceTargets[index].value);
      if(amount && price) {
        total += amount * price;
      }
    });

    // ugly making the total green when ready
    if(parseFloat(this.totalTarget.value) === parseFloat(total)) {
      this.totalTarget.classList.remove('is-invalid');
      this.totalTarget.classList.add('is-valid');
    }else{
      this.totalTarget.classList.remove('is-valid');
      this.totalTarget.classList.add('is-invalid');
    }
  }

  // https://github.com/jwald1/stimulus-tabs/blob/master/src/tabs_controller.js#L58
  hideContent(el) {
    el && (el.style.display = 'none')
  }

  showContent(el) {
    el && (el.style.display = '')
  }

}
