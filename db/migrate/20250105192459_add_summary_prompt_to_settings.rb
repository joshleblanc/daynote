class AddSummaryPromptToSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :settings, :summary_prompt, :text
  end
end
