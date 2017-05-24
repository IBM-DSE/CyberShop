class AddPreorderToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :preorder, :boolean
  end
end
