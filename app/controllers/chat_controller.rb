class ChatController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]

  def create
    prompt = params[:message]

    client = OpenAI::Client.new(api_key: ENV['OPENAI_ACCESS_TOKEN'])
    response = client.chat(
      parameters: {
        model: "ft:gpt-3.5-turbo-0125:personal:charitynest:ASiAsJL4",  # Fine-tuned model ID
        messages: [
          { role: "system", content: "You are CharityNest AI Assistant. CharityNest is a platform that facilitates donations to various charities and provides updates, news, and reports on the progress of specific projects. Users can also engage in forums related to each cause. As the AI assistant, your role is to help users with their donations, provide project updates, answer questions, and guide them through the platform's features." },
          { role: "user", content: prompt }
        ],
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
