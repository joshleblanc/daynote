OpenAI.configure do |config|
    config.access_token = Rails.application.credentials.dig(:openai, :token)
end