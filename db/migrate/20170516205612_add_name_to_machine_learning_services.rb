class AddNameToMachineLearningServices < ActiveRecord::Migration
  def change
    add_column :machine_learning_services, :name, :string
  end
end
