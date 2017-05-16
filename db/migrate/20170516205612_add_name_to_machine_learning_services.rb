class AddNameToMachineLearningServices < ActiveRecord::Migration[5.1]
  def change
    add_column :machine_learning_services, :name, :string
  end
end
