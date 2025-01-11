class ProcessEntriesJob < ApplicationJob
  def perform(entry)
    entry.regenerate!
  end
end
