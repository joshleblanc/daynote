class CurrentEntryController < ApplicationController
  def index
    date = Time.now
    @entry = Entry.where(created_at: date.beginning_of_day..date.end_of_day).first_or_create
  end
end
