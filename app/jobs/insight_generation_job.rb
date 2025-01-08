class InsightGenerationJob < ApplicationJob
  retry_on StandardError, wait: 5.seconds, attempts: 3

  def perform(entry)
    return if entry.content.blank?

    client = OpenAI::Client.new
    response = client.chat(parameters: {
                             model: "gpt-4o",
                             messages: [
                               {
                                 role: "developer", content: [
                                   { type: "text", text: Setting.instance.insight_prompt },
                                 ],
                               },
                               {
                                 role: "user", content: [
                                   { type: "text", text: entry.content.to_plain_text },
                                 ],
                               },
                             ],
                           })
    insights = response["choices"][0]["message"]["content"].gsub("```json", "").gsub("```", "")

    json = JSON.parse(insights)

    entry.insights.destroy_all

    json["sections"].each do |insight|
      entry.insights.create(context: insight["content"], insight: insight["insight"], label: insight["type"])
    end
  end
end
