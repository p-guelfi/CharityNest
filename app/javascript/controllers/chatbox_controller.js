import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["messages", "input"];

  connect() {
    console.log("Chatbox controller connected.");
    this.loadChatHistory();
    this.inputTarget.addEventListener("keydown", this.handleKeyDown.bind(this));

    // Attach handleModalShown to the Bootstrap modal's shown event
    const modalElement = document.getElementById("chatboxModal");
    modalElement.addEventListener("shown.bs.modal", this.handleModalShown.bind(this));
  }

  handleKeyDown(event) {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault();
      this.sendMessage(event);
    }
  }

  loadChatHistory() {
    const messagesDiv = this.messagesTarget;
    const chatHistory = JSON.parse(sessionStorage.getItem("chatHistory")) || [];

    chatHistory.forEach((message) => {
      const messageElement = document.createElement("div");

      if (message.sender === "You") {
        messageElement.classList.add("user-message");
        messageElement.innerHTML = `<i class="fa-regular fa-user"></i> ${message.text}`;
      } else if (message.sender === "CharityNest AI") {
        messageElement.classList.add("ai-message");
        messageElement.innerHTML = `<i class="fa-solid fa-crow"></i> ${message.text}`;
      }

      messagesDiv.appendChild(messageElement);
    });
  }

  saveChatHistory(messages) {
    sessionStorage.setItem("chatHistory", JSON.stringify(messages));
  }

  handleModalShown() {
    this.inputTarget.focus();

    // Only add the greeting if there’s no existing chat history
    const chatHistory = JSON.parse(sessionStorage.getItem("chatHistory")) || [];
    if (chatHistory.length === 0) {
      this.addInitialGreeting();
    }
  }

  addInitialGreeting() {
    const messagesDiv = this.messagesTarget;
    const greetingMessage = {
      sender: "CharityNest AI",
      text: "Hello, I'm the CharityNest AI assistant. How can I help you?",
    };

    const aiMessageElement = document.createElement("div");
    aiMessageElement.classList.add("ai-message");
    aiMessageElement.innerHTML = `<i class="fa-solid fa-crow"></i> ${greetingMessage.text}`;
    messagesDiv.appendChild(aiMessageElement);

    const chatHistory = [greetingMessage];
    this.saveChatHistory(chatHistory);
    messagesDiv.scrollTop = messagesDiv.scrollHeight;
  }

  sendMessage(event) {
    const message = this.inputTarget.value;
    if (message) {
      const messagesDiv = this.messagesTarget;
      let chatHistory = JSON.parse(sessionStorage.getItem("chatHistory")) || [];

      chatHistory.push({ sender: "You", text: message });
      const userMessageElement = document.createElement("div");
      userMessageElement.classList.add("user-message");
      userMessageElement.innerHTML = `<i class="fa-regular fa-user"></i> ${message}`;
      messagesDiv.appendChild(userMessageElement);

      this.inputTarget.value = "";
      this.saveChatHistory(chatHistory);

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
          chatHistory.push({ sender: "CharityNest AI", text: data.response });
          const aiMessageElement = document.createElement("div");
          aiMessageElement.classList.add("ai-message");
          aiMessageElement.innerHTML = `<i class="fa-solid fa-crow"></i> ${data.response}`;
          messagesDiv.appendChild(aiMessageElement);

          this.saveChatHistory(chatHistory);
          messagesDiv.scrollTop = messagesDiv.scrollHeight;
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
