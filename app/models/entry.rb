class Entry < ApplicationRecord
  has_rich_text :content

  has_one :entry_embedding

  # after_save :embed!

  def current?
    today = Time.now
    (today.beginning_of_day..today.end_of_day).cover?(created_at)
  end

  def next_entry
    date = created_at + 1.day
    Entry.where(created_at: date.beginning_of_day..date.end_of_day).first
  end

  def prev_entry
    date = created_at - 1.day
    Entry.where(created_at: date.beginning_of_day..date.end_of_day).last
  end

  def prev_entry?
    prev_entry.present?
  end

  def next_entry?
    next_entry.present?
  end

  def self.vector_search(embedding:, limit: 10)
    query = EntryEmbedding.nearest_neighbors(:embedding, embedding, distance: :euclidean).limit(limit)
    where(
      id: query.pluck(:entry_id),
    )
  end

  def embed!
    data = Embedding.create(content.to_plain_text).embedding

    if entry_embedding
      entry_embedding.update(embedding: data)
    else
      EntryEmbedding.create(entry: self, embedding: data)
    end
  end
end
