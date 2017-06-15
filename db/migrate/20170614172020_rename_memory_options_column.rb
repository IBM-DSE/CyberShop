class RenameMemoryOptionsColumn < ActiveRecord::Migration
  def change
    rename_column :products, :memory_options, :storage_options
  end
end
