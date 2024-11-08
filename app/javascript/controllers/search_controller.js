// app/javascript/controllers/search_controller.ts
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["queryField"]

  connect() {
    console.log(this.element)
    console.log(this.queryFieldTarget)
    this.queryFieldTarget.value = ""
  }
}
