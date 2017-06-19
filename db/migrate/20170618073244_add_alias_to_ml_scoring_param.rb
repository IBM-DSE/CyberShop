class AddAliasToMlScoringParam < ActiveRecord::Migration
  def change
    add_column :ml_scoring_params, :alias, :string
  end
end
