import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="news-subscription"
export default class extends Controller {
  connect() {
    const userLoggedIn = document.body.dataset.userLoggedIn === "true";
    const userId = Number(document.body.dataset.userId);
    console.log("User Logged In:", userId);
    if(userLoggedIn) {
      createConsumer().subscriptions.create(
        {channel: "CharityProjectChannel", id: userId},
        {received: (data) => {
          console.log("received data:", data)
          this.element.insertAdjacentHTML("afterbegin", `<div class="card-news">${data}</div>`)
        }}
      );

    }
  }
}
