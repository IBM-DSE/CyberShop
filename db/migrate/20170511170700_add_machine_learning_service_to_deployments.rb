class AddMachineLearningServiceToDeployments < ActiveRecord::Migration
  def change
    add_reference :deployments, :machine_learning_service, foreign_key: true
  end
end
