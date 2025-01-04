class EntryEmbedding < ApplicationRecord
  belongs_to :entry

  has_neighbors :embedding, dimensions: 384
end
