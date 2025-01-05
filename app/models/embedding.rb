class Embedding
  attr_accessor :embedding

  def initialize(embedding)
    @embedding = embedding
  end

  def self.create(input)
    new(Informers.pipeline("embedding").call(input))
  end
end
