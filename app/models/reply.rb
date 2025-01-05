class Reply < ApplicationRecord
  enum :urgency, [:green, :yellow, :red]
  belongs_to :entry
end
