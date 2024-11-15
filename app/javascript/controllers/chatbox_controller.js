import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["messages", "input"];

  connect() {
    console.log("Chatbox controller connected.");
    this.loadChatHistory();
    this.inputTarget.addEventListener("keydown", this.handleKeyDown.bind(this));

    if (!localStorage.getItem("hasOpenedChat")) {
      this.sendGreetingMessage();
      localStorage.setItem("hasOpenedChat", "true");
    }

    // Check if common questions were hidden on previous page load
    if (localStorage.getItem("commonQuestionsHidden") === "true") {
      this.hideCommonQuestions();
    }

    // Listen for changes in localStorage (across tabs)
    window.addEventListener("storage", (event) => {
      if (event.key === "chatHistory") {
        this.loadChatHistory(); // Reload chat history when it changes in another tab
      }
    });
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
    const chatHistory = JSON.parse(localStorage.getItem("chatHistory")) || [];

    messagesDiv.innerHTML = ''; // Clear the existing messages before loading new ones

    chatHistory.forEach((message) => {
      const messageWrapper = document.createElement("div");
      messageWrapper.classList.add("message-wrapper");

      const iconElement = document.createElement("div");
      iconElement.classList.add("message-icon");

      const messageElement = document.createElement("div");

      // Check if the message is from the AI and has HTML content
      if (message.sender === "You") {
        iconElement.innerHTML = '<i class="fa-solid fa-user"></i>';
        messageElement.classList.add("user-message");
        messageElement.textContent = message.text; // User's message is plain text
      } else if (message.sender === "CharityNest AI") {
        iconElement.innerHTML = '<i class="fa-solid fa-crow"></i>';
        messageElement.classList.add("ai-message");

        // Use innerHTML for AI messages to render HTML (if any)
        messageElement.innerHTML = message.text; // AI's message can contain HTML
      }

      messageWrapper.appendChild(iconElement);
      messageWrapper.appendChild(messageElement);
      messagesDiv.appendChild(messageWrapper);
    });

    // Scroll to the bottom after loading the chat history
    messagesDiv.scrollTop = messagesDiv.scrollHeight;
  }


  saveChatHistory(messages) {
    localStorage.setItem("chatHistory", JSON.stringify(messages));
  }

  sendGreetingMessage() {
    const messagesDiv = this.messagesTarget;
    let chatHistory = JSON.parse(localStorage.getItem("chatHistory")) || [];

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
      let chatHistory = JSON.parse(localStorage.getItem("chatHistory")) || [];

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

      // Show the titillating crow icon immediately after sending the user message
      const aiIconElement = document.createElement("div");
      aiIconElement.classList.add("message-icon", "titillating");
      aiIconElement.innerHTML = '<i class="fa-solid fa-crow"></i>';
      aiIconElement.setAttribute("id", "ai-titillating-crow"); // Add a unique ID
      const aiMessageWrapper = document.createElement("div");
      aiMessageWrapper.classList.add("message-wrapper");
      aiMessageWrapper.appendChild(aiIconElement);
      aiMessageWrapper.appendChild(document.createElement("div"));
      messagesDiv.appendChild(aiMessageWrapper);

      // Scroll to the bottom after sending the message
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

          // After AI's response is received, remove the titillating crow
          const titillatingCrow = document.getElementById("ai-titillating-crow");
          if (titillatingCrow) {
            titillatingCrow.parentElement.remove(); // Remove the titillating crow element
          }

          const aiMessageWrapper = document.createElement("div");
          aiMessageWrapper.classList.add("message-wrapper");

          const aiIconElement = document.createElement("div");
          aiIconElement.classList.add("message-icon");
          aiIconElement.innerHTML = '<i class="fa-solid fa-crow"></i>';

          const aiMessageElement = document.createElement("div");
          aiMessageElement.classList.add("ai-message");

          // This is where you allow HTML to render correctly, using innerHTML instead of textContent
          aiMessageElement.innerHTML = data.response;  // This will allow the link to render as HTML

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
      localStorage.setItem("commonQuestionsHidden", "true"); // Save state to localStorage
    }
  }
}
