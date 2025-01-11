class Entry < ApplicationRecord
  has_rich_text :content

  has_one :entry_embedding
  has_one :reply
  has_one_attached :image
  has_many :insights

  belongs_to :user

  def editable?(current_user)
    current? || current_user&.admin?
  end

  def current?
    Time.use_zone(user.timezone) do
      today = Time.current
      (today.beginning_of_day..today.end_of_day).cover?(created_at)
    end
  end

  def future_entries
    Entry.where(created_at: created_at.., user: user).order(:created_at)
  end

  def past_entries
    Entry.where(created_at: ..created_at, user: user).order(:created_at)
  end

  def next_entry
    future_entries.second
  end

  def prev_entry
    past_entries.second_to_last
  end

  def prev_entry?
    prev_entry.present?
  end

  def next_entry?
    next_entry.present?
  end

  def self.vector_search(embedding:, limit: 10)
    query = EntryEmbedding.joins(entry: [:rich_text_content]).where("action_text_rich_texts.body IS NOT NULL").nearest_neighbors(:embedding, embedding, distance: :euclidean).limit(limit)
    where(
      id: query.pluck(:entry_id),
    )
  end

  def regenerate_image!
    ImageGenerationJob.perform_later(self)
  end

  def regenerate_insights!
    InsightGenerationJob.perform_later(self)
  end

  def regenerate_reply!
    ReplyGenerationJob.perform_later(self)
  end

  def regenerate_summary!
    SummaryGenerationJob.perform_later(self)
  end

  def regenerate!
    regenerate_image!
    regenerate_insights!
    regenerate_reply!
    regenerate_summary!
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
