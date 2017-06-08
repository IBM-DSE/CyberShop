class CreateTrendingTopics < ActiveRecord::Migration
  def change
    create_table :trending_topics do |t|
      t.string :name
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
