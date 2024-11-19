import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="input-dicussion"
export default class extends Controller {
  static targets = ["collapsable", "close"]
  connect() {
    console.log("connected")
  }
  uncollapse() {
    console.log("focused")
    this.collapsableTarget.classList.remove("d-none")
    this.closeTarget.classList.remove("d-none")
  }
  collapse() {
    console.log("closed")
    this.collapsableTarget.classList.add("d-none")
    this.closeTarget.classList.add("d-none")
  }
}
