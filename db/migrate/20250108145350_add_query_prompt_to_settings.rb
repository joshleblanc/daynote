class AddQueryPromptToSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :settings, :query_prompt, :text
  end
end
