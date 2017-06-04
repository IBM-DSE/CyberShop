class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.references :product, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
