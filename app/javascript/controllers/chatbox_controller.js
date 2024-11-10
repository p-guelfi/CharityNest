import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["messages", "input"];

  connect() {
    console.log("Chatbox controller connected.");
    this.loadChatHistory();
  }

  loadChatHistory() {
    const messagesDiv = this.messagesTarget;
    const chatHistory = JSON.parse(sessionStorage.getItem("chatHistory")) || [];

    chatHistory.forEach((message) => {
      messagesDiv.innerHTML += `<div>${message.sender}: ${message.text}</div>`;
    });
  }

  saveChatHistory(messages) {
    sessionStorage.setItem("chatHistory", JSON.stringify(messages));
  }

  // Toggle the modal visibility
  toggleModal() {
    const modal = document.getElementById("chatboxModal");
    modal.classList.toggle("show"); // Show or hide the modal
    document.body.classList.toggle("modal-open"); // Optional: Prevent scrolling when modal is open
  }

  // Close the modal (triggered by the close button or clicking outside)
  closeModal() {
    const modal = document.getElementById("chatboxModal");
    modal.classList.remove("show");
    document.body.classList.remove("modal-open"); // Optional: Allow scrolling when modal is closed
  }

  sendMessage(event) {
    const message = this.inputTarget.value;
    if (message) {
      const messagesDiv = this.messagesTarget;
      let chatHistory = JSON.parse(sessionStorage.getItem("chatHistory")) || [];

      // Add user message to chat history
      chatHistory.push({ sender: "You", text: message });
      messagesDiv.innerHTML += `<div class="user-message">You: ${message}</div>`;
      this.inputTarget.value = ""; // Clear input field
      this.saveChatHistory(chatHistory);

      // Send the message to the server
      fetch("/chat", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        },
        body: JSON.stringify({ message: message }),
      })
        .then((response) => response.json())
        .then((data) => {
          // Add AI response to chat history
          chatHistory.push({ sender: "CharityNest AI", text: data.response });
          messagesDiv.innerHTML += `<div class="ai-message">CharityNest AI: ${data.response}</div>`;
          this.saveChatHistory(chatHistory);
          messagesDiv.scrollTop = messagesDiv.scrollHeight; // Scroll to the bottom
        })
        .catch((error) => {
          console.error("Error:", error);
          messagesDiv.innerHTML += `<div>Error: ${error.message}</div>`;
          messagesDiv.scrollTop = messagesDiv.scrollHeight;
        });
    }
  }
}
