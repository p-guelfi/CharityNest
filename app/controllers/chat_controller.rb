class ChatController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]

  def create
    prompt = params[:message]

    client = OpenAI::Client.new(api_key: ENV['OPENAI_ACCESS_TOKEN'])
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt }],
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
