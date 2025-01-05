class SummaryGenerationJob < ApplicationJob
  retry_on StandardError, wait: 5.seconds, attempts: 3

  def perform(entry)
    return if entry.content.blank?

    client = OpenAI::Client.new
    response = client.chat(parameters: {
                             model: "gpt-4o",
                             messages: [
                               {
                                 role: "developer", content: [
                                   { type: "text", text: Setting.instance.summary_prompt },
                                 ],
                               },
                               {
                                 role: "user", content: [
                                   { type: "text", text: entry.content.to_plain_text },
                                 ],
                               },
                             ],
                           })
    summary = response["choices"][0]["message"]["content"].gsub("```json", "").gsub("```", "")

    json = JSON.parse(summary)

    entry.update(summary: json["summary"])
  end
end
