class CreateSettings < ActiveRecord::Migration[8.0]
  def change
    create_table :settings do |t|
      t.text :insight_prompt
      t.text :image_prompt

      t.timestamps
    end
  end
end
