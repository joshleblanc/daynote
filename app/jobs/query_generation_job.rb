class QueryGenerationJob < ApplicationJob
  def perform(query, context)
    return if query.blank?
    client = OpenAI::Client.new

    response = client.chat(parameters: {
                             model: "gpt-4o",
                             messages: [
                               {
                                 role: "developer", content: [
                                   { type: "text", text: Setting.instance.query_prompt.gsub("[CONTEXT]", context.to_json(includes: :content)) },
                                 ],
                               },
                               {
                                 role: "user", content: [
                                   { type: "text", text: query },
                                 ],
                               },
                             ],
                           })
    json = response["choices"][0]["message"]["content"].gsub("```json", "").gsub("```", "")

    JSON.parse(json)
  end
end
