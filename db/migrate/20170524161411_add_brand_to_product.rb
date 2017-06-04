class AddBrandToProduct < ActiveRecord::Migration
  def change
    add_reference :products, :brand, foreign_key: true
  end
end
