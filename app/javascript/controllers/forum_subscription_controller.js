import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="forum-subscription"
export default class extends Controller {
  static targets = ["button", "messages"]
  connect() {
    const userLoggedIn = document.body.dataset.userLoggedIn === "true";
    const userId = Number(document.body.dataset.userId);

    if(userLoggedIn) {
      createConsumer().subscriptions.create(
        {channel: "ForumChannel", id: userId},
        {received: (data) => {
          this.buttonTarget.classList.add("titillating")
          this.messagesTarget.insertAdjacentHTML("beforeend", data)
        }}
      );

    }
  }
  untitillate() {
    console.log("clicked")
    if (this.buttonTarget.classList.contains("titillating")) {
      this.buttonTarget.classList.remove("titillating")
    }
  }
}
