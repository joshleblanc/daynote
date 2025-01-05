class ImageGenerationJob < ApplicationJob
  def perform(entry)
    return if entry.content.blank?

    client = OpenAI::Client.new
    result = client.images.generate(parameters: {
                                      model: "dall-e-3",
                                      prompt: "#{Setting.instance.image_prompt}: #{entry.content.to_plain_text}",
                                    })
    image_url = result["data"][0]["url"]
    image_data = URI.parse(image_url).open
    entry.image.attach(io: image_data, filename: "diary_entry_image.jpg")
  end
end
