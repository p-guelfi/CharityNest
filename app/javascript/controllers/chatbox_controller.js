import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["chatbox", "messages", "input"];

  connect() {
    console.log("Chatbox controller connected.");
  }

  toggleMinimize() {
    const chatbox = this.chatboxTarget;
    chatbox.classList.toggle("chatbox-minimized");

    // Toggle visibility of messages and input
    if (chatbox.classList.contains("chatbox-minimized")) {
      this.messagesTarget.style.display = "none";
      this.inputTarget.style.display = "none";
    } else {
      this.messagesTarget.style.display = "block";
      this.inputTarget.style.display = "block";
    }
  }
}
