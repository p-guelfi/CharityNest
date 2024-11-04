import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sort-index"
export default class extends Controller {
  connect() {
    console.log("connected")
  }
  toggleSort(event) {
    console.log("clicked")
  }
  #loadSorted(sortBy) {
    // Get the elements sorted by the given attribute
    // query the db with sorting column
    // parse the sorted elements and replace them in the index
  }
}
