import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["messages", "input"];

  connect() {
    console.log("Chatbox controller connected.");
    this.loadChatHistory();
    this.inputTarget.addEventListener("keydown", this.handleKeyDown.bind(this)); // Add event listener for Enter key
  }

  handleKeyDown(event) {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault(); // Prevent form submission
      this.sendMessage(event); // Trigger the sendMessage method
    }
  }

  loadChatHistory() {
    const messagesDiv = this.messagesTarget;
    const chatHistory = JSON.parse(sessionStorage.getItem("chatHistory")) || [];

    chatHistory.forEach((message) => {
      const messageElement = document.createElement("div");

      // Add the appropriate class based on the sender
      if (message.sender === "You") {
        messageElement.classList.add("user-message");
      } else if (message.sender === "CharityNest AI") {
        messageElement.classList.add("ai-message");
      }

      // Set the message text
      messageElement.textContent = `${message.sender}: ${message.text}`;

      // Append the message to the chat history
      messagesDiv.appendChild(messageElement);
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
      const userMessageElement = document.createElement("div");
      userMessageElement.classList.add("user-message");
      userMessageElement.textContent = `You: ${message}`;
      messagesDiv.appendChild(userMessageElement);

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
          const aiMessageElement = document.createElement("div");
          aiMessageElement.classList.add("ai-message");
          aiMessageElement.textContent = `CharityNest AI: ${data.response}`;
          messagesDiv.appendChild(aiMessageElement);

          this.saveChatHistory(chatHistory);
          messagesDiv.scrollTop = messagesDiv.scrollHeight; // Scroll to the bottom
        })
        .catch((error) => {
          console.error("Error:", error);
          const errorElement = document.createElement("div");
          errorElement.textContent = `Error: ${error.message}`;
          messagesDiv.appendChild(errorElement);
          messagesDiv.scrollTop = messagesDiv.scrollHeight;
        });
    }
  }
}
