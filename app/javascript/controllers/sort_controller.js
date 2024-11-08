import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["ListToSort"]

  connect() {
    console.log("This is the Sort controller")
    console.log(this.ListToSortTarget)
  }

  // Method to toggle sort order
  toggleOrder(attribute) {
    let currentOrder = this.element.getAttribute(`data-${attribute}-order`) || 'asc';
    let nextOrder = currentOrder === 'asc' ? 'desc' : 'asc';
    this.element.setAttribute(`data-${attribute}-order`, nextOrder); // Store the next order in the element attribute

    this.sortList(attribute, nextOrder);
  }

  // Method to sort the list based on the chosen attribute and order
  sortList(attribute, order) {
    let list = this.ListToSortTarget;
    let items = Array.from(list.children); // Get all items in the list
    let sortedItems;

    // Sort the items based on attribute
    if (attribute === 'name') {
      sortedItems = items.sort((a, b) => {
        let nameA = a.querySelector('.project-name') ? a.querySelector('.project-name').textContent.trim().toLowerCase() : '';
        let nameB = b.querySelector('.project-name') ? b.querySelector('.project-name').textContent.trim().toLowerCase() : '';
        return order === 'asc' ? nameA.localeCompare(nameB) : nameB.localeCompare(nameA);
      });
    } else if (attribute === 'location') {
      sortedItems = items.sort((a, b) => {
        let locationA = a.querySelector('.project-location') ? a.querySelector('.project-location').textContent.trim().toLowerCase() : '';
        let locationB = b.querySelector('.project-location') ? b.querySelector('.project-location').textContent.trim().toLowerCase() : '';
        return order === 'asc' ? locationA.localeCompare(locationB) : locationB.localeCompare(locationA);
      });
    } else if (attribute === 'goal') {
      sortedItems = items.sort((a, b) => {
        let goalA = a.dataset.goal ? parseInt(a.dataset.goal, 10) : 0;
        let goalB = b.dataset.goal ? parseInt(b.dataset.goal, 10) : 0;
        return order === 'asc' ? goalA - goalB : goalB - goalA;  // Corrected: use `order` instead of `this.order`
      });
    }

    // Clear and append
    list.innerHTML = '';
    sortedItems.forEach(item => list.appendChild(item));
  }

  // Event handler for sorting by name
  sortByName(event) {
    event.preventDefault();
    this.toggleOrder('name');
  }

  // Event handler for sorting by location
  sortByLocation(event) {
    event.preventDefault();
    this.toggleOrder('location');
  }

  // Event handler for sorting by goal
  sortByGoal(event) {
    event.preventDefault();
    this.toggleOrder('goal');
  }
}
