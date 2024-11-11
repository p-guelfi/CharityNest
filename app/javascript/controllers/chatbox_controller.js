import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["messages", "input"];

  connect() {
    console.log("Chatbox controller connected.");
    this.loadChatHistory();
    this.inputTarget.addEventListener("keydown", this.handleKeyDown.bind(this));

    if (!sessionStorage.getItem("hasOpenedChat")) {
      this.sendGreetingMessage();
      sessionStorage.setItem("hasOpenedChat", "true");
    }
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
      const messageWrapper = document.createElement("div");
      messageWrapper.classList.add("message-wrapper");

      const iconElement = document.createElement("div");
      iconElement.classList.add("message-icon");

      const messageElement = document.createElement("div");
      messageElement.textContent = message.text;

      if (message.sender === "You") {
        iconElement.innerHTML = '<i class="fa-regular fa-user"></i>';
        messageElement.classList.add("user-message");
      } else if (message.sender === "CharityNest AI") {
        iconElement.innerHTML = '<i class="fa-solid fa-crow"></i>';
        messageElement.classList.add("ai-message");
      }

      messageWrapper.appendChild(iconElement);
      messageWrapper.appendChild(messageElement);
      messagesDiv.appendChild(messageWrapper);
    });
  }

  saveChatHistory(messages) {
    sessionStorage.setItem("chatHistory", JSON.stringify(messages));
  }

  sendGreetingMessage() {
    const messagesDiv = this.messagesTarget;
    let chatHistory = JSON.parse(sessionStorage.getItem("chatHistory")) || [];

    const greetingMessage = "Hello, I'm the CharityNest AI assistant. How can I help you?";
    chatHistory.push({ sender: "CharityNest AI", text: greetingMessage });

    const messageWrapper = document.createElement("div");
    messageWrapper.classList.add("message-wrapper");

    const iconElement = document.createElement("div");
    iconElement.classList.add("message-icon");
    iconElement.innerHTML = '<i class="fa-solid fa-crow"></i>';

    const messageElement = document.createElement("div");
    messageElement.classList.add("ai-message");
    messageElement.textContent = greetingMessage;

    messageWrapper.appendChild(iconElement);
    messageWrapper.appendChild(messageElement);
    messagesDiv.appendChild(messageWrapper);

    this.saveChatHistory(chatHistory);
  }

  sendMessage(event) {
    const message = this.inputTarget.value;
    if (message) {
      const messagesDiv = this.messagesTarget;
      let chatHistory = JSON.parse(sessionStorage.getItem("chatHistory")) || [];

      // Add user message to chat history
      chatHistory.push({ sender: "You", text: message });

      const messageWrapper = document.createElement("div");
      messageWrapper.classList.add("message-wrapper");

      const iconElement = document.createElement("div");
      iconElement.classList.add("message-icon");
      iconElement.innerHTML = '<i class="fa-solid fa-user"></i>';

      const userMessageElement = document.createElement("div");
      userMessageElement.classList.add("user-message");
      userMessageElement.textContent = message;

      messageWrapper.appendChild(iconElement);
      messageWrapper.appendChild(userMessageElement);
      messagesDiv.appendChild(messageWrapper);

      this.inputTarget.value = "";
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
          chatHistory.push({ sender: "CharityNest AI", text: data.response });

          const aiMessageWrapper = document.createElement("div");
          aiMessageWrapper.classList.add("message-wrapper");

          const aiIconElement = document.createElement("div");
          aiIconElement.classList.add("message-icon");
          aiIconElement.innerHTML = '<i class="fa-solid fa-crow"></i>';

          const aiMessageElement = document.createElement("div");
          aiMessageElement.classList.add("ai-message");
          aiMessageElement.textContent = data.response;

          aiMessageWrapper.appendChild(aiIconElement);
          aiMessageWrapper.appendChild(aiMessageElement);
          messagesDiv.appendChild(aiMessageWrapper);

          this.saveChatHistory(chatHistory);
          messagesDiv.scrollTop = messagesDiv.scrollHeight;
        })
        .catch((error) => {
          console.error("Error:", error);

          const errorElement = document.createElement("div");
          errorElement.classList.add("error-message");
          errorElement.textContent = `Error: ${error.message}`;
          messagesDiv.appendChild(errorElement);
          messagesDiv.scrollTop = messagesDiv.scrollHeight;
        });
    }
  }
}
