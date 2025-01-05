class CreateReplies < ActiveRecord::Migration[8.0]
  def change
    create_table :replies do |t|
      t.text :reply
      t.integer :urgency
      t.belongs_to :entry, null: false, foreign_key: true

      t.timestamps
    end
  end
end
