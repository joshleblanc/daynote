class AddReplyPromptToSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :settings, :reply_prompt, :text
  end
end
