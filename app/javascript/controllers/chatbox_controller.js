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

    if (sessionStorage.getItem("commonQuestionsHidden") === "true") {
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
    const chatHistory = JSON.parse(sessionStorage.getItem("chatHistory")) || [];
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
    sessionStorage.setItem("chatHistory", JSON.stringify(messages));
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
    return JSON.parse(sessionStorage.getItem("chatHistory")) || [];
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
      sessionStorage.setItem("commonQuestionsHidden", "true");
    }
  }
}
