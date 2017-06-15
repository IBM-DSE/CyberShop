class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.references :product, index: true, foreign_key: true
      t.string :description
    end
  end
end
