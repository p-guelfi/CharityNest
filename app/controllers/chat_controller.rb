class ChatController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]

  def create
    messages = params[:messages] || []
    prompt = messages.map { |msg| { role: msg['sender'] == "You" ? 'user' : 'assistant', content: msg['text'] } }

    client = OpenAI::Client.new(api_key: ENV['OPENAI_ACCESS_TOKEN'])
    response = client.chat(
      parameters: {
        model: "ft:gpt-3.5-turbo-0125:personal:charitynest:ASkUktHP",  # Fine-tuned model ID
        messages: prompt,
        max_tokens: 150
      }
    )

    if response["choices"].any?
      render json: { response: response["choices"].first["message"]["content"] }
    else
      render json: { error: "No response from OpenAI" }, status: 500
    end
  rescue Faraday::Error => e
    logger.error "OpenAI API error: #{e.message}"
    render json: { error: "OpenAI API request failed" }, status: 500
  end
end
