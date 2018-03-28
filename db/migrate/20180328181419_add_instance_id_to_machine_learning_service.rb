class AddInstanceIdToMachineLearningService < ActiveRecord::Migration
  def change
    add_column :machine_learning_services, :instance_id, :string
  end
end
