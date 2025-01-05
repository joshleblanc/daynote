class AddSummaryToEntries < ActiveRecord::Migration[8.0]
  def change
    add_column :entries, :summary, :text
  end
end
