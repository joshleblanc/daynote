class InsightGenerationJob < ApplicationJob
  def perform(entry)
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
    entry.insights.destroy_all
    JSON.parse(insights)["sections"].each do |insight|
      entry.insights.create(context: insight["content"], insight: insight["insight"], label: insight["type"])
    end
  end
end
