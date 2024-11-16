import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["messages", "input"];

  connect() {
    console.log("Chatbox controller connected.");

    // Ensure we get the user login state correctly from the body tag
    const userLoggedIn = document.body.dataset.userLoggedIn === "true";
    console.log("User Logged In:", userLoggedIn);

    // Use localStorage for logged-in users, sessionStorage otherwise
    this.storage = userLoggedIn ? localStorage : sessionStorage;

    // Log storage type to verify
    console.log("Using storage:", this.storage);

    if (!this.storage) {
      this.storage = sessionStorage;  // Fallback to sessionStorage if undefined
    }

    this.loadChatHistory();
    this.inputTarget.addEventListener("keydown", this.handleKeyDown.bind(this));

    if (!this.storage.getItem("hasOpenedChat")) {
      this.sendGreetingMessage();
      this.storage.setItem("hasOpenedChat", "true");
    }

    if (this.storage.getItem("commonQuestionsHidden") === "true") {
      this.hideCommonQuestions();
    }

    window.addEventListener("storage", (event) => {
      if (event.key === "chatHistory") this.loadChatHistory();
    });
  }

  handleKeyDown(event) {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault();
      this.sendMessage();
      this.hideCommonQuestions();
    }
  }

  loadChatHistory() {
    const chatHistory = JSON.parse(this.storage.getItem("chatHistory")) || [];
    console.log("Loaded Chat History:", chatHistory); // Log chat history
    this.messagesTarget.innerHTML = chatHistory.map(this.formatMessage).join("");
    this.scrollToBottom();
  }

  formatMessage({ sender, text }) {
    const isUser = sender === "You";
    const messageContent = isUser
      ? `<div class="user-message">${text}</div>`
      : `<div class="ai-message">${text}</div>`; // AI message uses innerHTML for potential HTML content

    return `
      <div class="message-wrapper">
        <div class="message-icon"><i class="fa-solid fa-${isUser ? "user" : "crow"}"></i></div>
        ${messageContent}
      </div>`;
  }

  saveChatHistory(messages) {
    this.storage.setItem("chatHistory", JSON.stringify(messages));
  }

  sendGreetingMessage() {
    const greeting = "Hello, I'm the CharityNest AI assistant. How can I help you?";
    this.addMessage({ sender: "CharityNest AI", text: greeting });
  }

  sendMessage() {
    const message = this.inputTarget.value.trim();
    if (!message) return;

    this.addMessage({ sender: "You", text: message });
    this.inputTarget.value = "";

    // Show the titillating crow icon
    const crowIcon = `
      <div class="message-wrapper" id="titillating-crow">
        <div class="message-icon"><i class="fa-solid fa-crow titillating"></i></div>
      </div>`;
    this.messagesTarget.insertAdjacentHTML("beforeend", crowIcon);
    this.scrollToBottom();

    fetch("/chat", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
      },
      body: JSON.stringify({ messages: this.getChatHistory() }),
    })
      .then((res) => res.json())
      .then((data) => {
        // Remove the titillating crow icon
        document.getElementById("titillating-crow")?.remove();
        this.addMessage({ sender: "CharityNest AI", text: data.response });
      })
      .catch((error) => {
        document.getElementById("titillating-crow")?.remove();
        this.displayError(error.message);
      });
  }

  addMessage(message) {
    const chatHistory = this.getChatHistory();
    chatHistory.push(message);
    this.saveChatHistory(chatHistory);

    this.messagesTarget.insertAdjacentHTML("beforeend", this.formatMessage(message));
    this.scrollToBottom();
  }

  getChatHistory() {
    return JSON.parse(this.storage.getItem("chatHistory")) || [];
  }

  displayError(error) {
    this.messagesTarget.insertAdjacentHTML(
      "beforeend",
      `<div class="error-message">Error: ${error}</div>`
    );
    this.scrollToBottom();
  }

  scrollToBottom() {
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
  }

  askQuestion(event) {
    this.inputTarget.value = event.target.textContent;
    this.sendMessage();
    this.hideCommonQuestions();
  }

  hideCommonQuestions() {
    const commonQuestions = this.element.querySelector(".common-questions");
    if (commonQuestions) {
      commonQuestions.style.display = "none";
      this.storage.setItem("commonQuestionsHidden", "true");
    }
  }
}
