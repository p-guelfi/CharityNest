import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["chatbox", "messages", "input"];

  connect() {
    console.log("Chatbox controller connected.");
    this.loadChatHistory(); // Load chat history when the controller is connected
    this.restoreChatboxState(); // Restore the chatbox state (minimized or not)
  }

  toggleMinimize() {
    const chatbox = this.chatboxTarget;
    chatbox.classList.toggle("chatbox-minimized");

    // Toggle visibility of messages and input
    if (chatbox.classList.contains("chatbox-minimized")) {
      this.messagesTarget.style.display = "none";
      this.inputTarget.style.display = "none";
      sessionStorage.setItem('chatboxState', 'minimized'); // Save the minimized state
    } else {
      this.messagesTarget.style.display = "block";
      this.inputTarget.style.display = "block";
      sessionStorage.setItem('chatboxState', 'expanded'); // Save the expanded state
    }
  }

  loadChatHistory() {
    const messagesDiv = this.messagesTarget;
    const chatHistory = JSON.parse(sessionStorage.getItem('chatHistory')) || [];

    console.log('Loaded chat history:', chatHistory); // Log to check if data is being loaded

    chatHistory.forEach(message => {
      messagesDiv.innerHTML += `<div>${message.sender}: ${message.text}</div>`;
    });
  }

  saveChatHistory(messages) {
    console.log('Saving chat history:', messages); // Log to check if data is being saved
    sessionStorage.setItem('chatHistory', JSON.stringify(messages));
  }

  restoreChatboxState() {
    const chatboxState = sessionStorage.getItem('chatboxState');
    if (chatboxState === 'minimized') {
      this.chatboxTarget.classList.add("chatbox-minimized");
      this.messagesTarget.style.display = "none";
      this.inputTarget.style.display = "none";
    } else {
      this.chatboxTarget.classList.remove("chatbox-minimized");
      this.messagesTarget.style.display = "block";
      this.inputTarget.style.display = "block";
    }
  }

  sendMessage(event) {
    let message = this.inputTarget.value;
    if (message) {
      let messagesDiv = this.messagesTarget;

      // Get the current chat history from sessionStorage
      let chatHistory = JSON.parse(sessionStorage.getItem('chatHistory')) || [];

      // Add user message to chat history
      chatHistory.push({ sender: 'You', text: message });
      console.log('Chat history after adding user message:', chatHistory); // Log chat history after adding the user message

      // Update the chatbox with new message
      messagesDiv.innerHTML += `<div>You: ${message}</div>`;
      this.inputTarget.value = '';

      // Save the updated chat history to sessionStorage
      this.saveChatHistory(chatHistory);

      // Send the message to the server
      fetch('/chat', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
        },
        body: JSON.stringify({ message: message })
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.json();
      })
      .then(data => {
        // Add AI response to chat history and update chatbox
        let chatHistory = JSON.parse(sessionStorage.getItem('chatHistory')) || [];
        chatHistory.push({ sender: 'CharityNest AI', text: data.response });
        console.log('Chat history after adding AI response:', chatHistory); // Log chat history after adding AI response

        // Display the AI response
        messagesDiv.innerHTML += `<div>CharityNest AI: ${data.response}</div>`;

        // Save the updated chat history to sessionStorage
        this.saveChatHistory(chatHistory);

        // Scroll to the bottom to show the latest message
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
      })
      .catch(error => {
        console.error('Error:', error);
        messagesDiv.innerHTML += `<div>Error: ${error.message}</div>`;
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
      });
    }
  }
}
