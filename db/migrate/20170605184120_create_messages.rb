class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.boolean :watson_response
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
