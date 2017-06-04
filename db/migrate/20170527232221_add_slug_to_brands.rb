class AddSlugToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :slug, :string
    add_index :brands, :slug, unique: true
  end
end
