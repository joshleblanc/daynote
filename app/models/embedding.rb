class Embedding
  attr_accessor :embedding

  def initialize(embedding)
    @embedding = embedding
  end

  def self.create(input)
    # embedding = OpenAI::Client.new
    #   .embeddings(parameters: { model: "text-embedding-3-small", input:, encoding_format: "float" })
    #   .fetch("data")[0]["embedding"]
    # new(embedding)
    embedding = ActiveRecord::Base.connection.execute("select lembed('all-MiniLM-L6-v2', $1)", [input])
    new(embedding.first.values.first)
  end
end
