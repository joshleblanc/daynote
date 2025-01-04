class CreateEntryEmbeddings < ActiveRecord::Migration[8.0]
  def change
    create_virtual_table :entry_embeddings, :vec0, ['embedding float[1536]']
  end
end
