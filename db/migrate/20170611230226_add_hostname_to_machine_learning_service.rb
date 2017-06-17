class AddHostnameToMachineLearningService < ActiveRecord::Migration
  def change
    add_column :machine_learning_services, :hostname, :string
  end
end
