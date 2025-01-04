class CreateEntryEmbeddings < ActiveRecord::Migration[8.0]
  def change
    create_virtual_table :entry_embeddings, :vec0, [
      "id integer PRIMARY KEY AUTOINCREMENT NOT NULL",
      "entry_id integer FORIENG KEY NOT NULL",
      "embedding float[384] distance_metric=L2",
    ]
  end
end
