class EmbeddingGenerationJob < ApplicationJob
  retry_on StandardError, wait: 5.seconds, attempts: 3

  def perform(entry)
    entry.embed!
  end
end
