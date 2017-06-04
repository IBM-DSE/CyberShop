class CreateMlScoringParamOptions < ActiveRecord::Migration
  def change
    create_table :ml_scoring_param_options do |t|
      t.references :ml_scoring_param, foreign_key: true
      t.string :value
    end
  end
end
