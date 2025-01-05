class CreateInsights < ActiveRecord::Migration[8.0]
  def change
    create_table :insights do |t|
      t.text :context
      t.text :insight
      t.string :label
      t.belongs_to :entry, null: false, foreign_key: true

      t.timestamps
    end
  end
end
