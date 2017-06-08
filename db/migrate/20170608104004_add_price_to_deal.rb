class AddPriceToDeal < ActiveRecord::Migration
  def change
    add_column :deals, :price, :decimal
  end
end
