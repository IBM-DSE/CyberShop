class CreateMlScoringParams < ActiveRecord::Migration
  def change
    create_table :ml_scoring_params do |t|
      t.string :name, unique: true, index: true
    end
  end
end
