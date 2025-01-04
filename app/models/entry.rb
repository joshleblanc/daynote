class Entry < ApplicationRecord
    has_rich_text :content

    has_one :entry_embedding, foreign_key: :rowid
    
    def self.vector_search(embedding:, limit: 10)
        # where(
        #     id: EntryEmbedding.nearest_neighbors(:embedding, embedding.to_s, distance: :euclidean).limit(limit).pluck(:keyid)
        # )
    end

    def create_embedding
        # data = OpenAI::Client.new
        #     .embeddings(parameters: { model: "text-embedding-3-small", input: })
        #     .fetch("data")[0]["embedding"]
        # entry_embedding.create(embedding: data)
    end
end
