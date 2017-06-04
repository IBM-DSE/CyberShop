class AddPreorderToProducts < ActiveRecord::Migration
  def change
    add_column :products, :preorder, :boolean
  end
end
