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

    // Check if common questions were hidden on previous page load
    if (sessionStorage.getItem("commonQuestionsHidden") === "true") {
      this.hideCommonQuestions();
    }
  }

  handleKeyDown(event) {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault();
      this.sendMessage(event);

      // Hide the common questions section when the user types a question
      this.hideCommonQuestions();
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
        iconElement.innerHTML = '<i class="fa-solid fa-user"></i>';
        messageElement.classList.add("user-message");
      } else if (message.sender === "CharityNest AI") {
        iconElement.innerHTML = '<i class="fa-solid fa-crow"></i>';
        messageElement.classList.add("ai-message");
      }

      messageWrapper.appendChild(iconElement);
      messageWrapper.appendChild(messageElement);
      messagesDiv.appendChild(messageWrapper);
    });

    // Scroll to the bottom after loading the chat history
    messagesDiv.scrollTop = messagesDiv.scrollHeight;
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

    // Scroll to the bottom after sending the greeting
    messagesDiv.scrollTop = messagesDiv.scrollHeight;
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

      // Scroll to the bottom after the user sends a message
      messagesDiv.scrollTop = messagesDiv.scrollHeight;

      // Send the full conversation history to the server
      fetch("/chat", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        },
        body: JSON.stringify({ messages: chatHistory }), // Send the full chat history
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

          // Scroll to the bottom after the AI sends a response
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

  askQuestion(event) {
    // Set the clicked question as input message
    const question = event.target.textContent;
    this.inputTarget.value = question;
    this.sendMessage(event); // Optionally, auto-send the question

    // Remove the clicked question
    event.target.closest('.question-wrapper').remove();

    // Hide the entire common questions section
    this.hideCommonQuestions();
  }

  hideCommonQuestions() {
    const commonQuestionsDiv = this.element.querySelector('.common-questions');
    if (commonQuestionsDiv) {
      commonQuestionsDiv.style.display = 'none';
      sessionStorage.setItem("commonQuestionsHidden", "true"); // Save state to sessionStorage
    }
  }
}
