import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="two-grid-columns-to-tabs"
export default class extends Controller {
  static targets = [ "button1", "button2", "content0", "content1", "content2" ]
  connect() {
  }
  select1(e) {
    this.button1Target.classList.add("active")
    this.button2Target.classList.remove("active")
    this.content0Target.classList.remove("d-none")
    this.content1Target.classList.remove("d-none")
    this.content2Target.classList.add("d-none")
  }
  select2(e) {
    this.button1Target.classList.remove("active")
    this.button2Target.classList.add("active")
    this.content0Target.classList.add("d-none")
    this.content1Target.classList.add("d-none")
    this.content2Target.classList.remove("d-none")
  }
}
