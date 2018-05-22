import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'chart' ]

  initialize() {
  }

  connect() {
    var chart = Chartkick.charts["my-chart"];
    // chart.updateData({});
    // console.log(chart)
    // console.log(Chartkick.charts)
  }
}
