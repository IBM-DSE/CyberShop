class AddColorAndMemoryToProducts < ActiveRecord::Migration
  def change
    add_column :products, :color_options, :text
    add_column :products, :memory_options, :text
  end
end
