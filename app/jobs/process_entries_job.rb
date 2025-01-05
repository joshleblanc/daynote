class ProcessEntriesJob < ApplicationJob
  def perform
    day = Time.now - 1.day
    entries = Entry.where(created_at: day.beginning_of_day..day.end_of_day)

    entries.each do |entry|
      if entry.content.blank?
        entry.destroy
      else
        entry.regenerate!
      end
    end
  end
end
