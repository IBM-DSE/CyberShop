class AddMachineLearningServiceToDeployments < ActiveRecord::Migration[5.1]
  def change
    add_reference :deployments, :machine_learning_service, foreign_key: true
  end
end
