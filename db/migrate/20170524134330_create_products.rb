class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.references :category, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
