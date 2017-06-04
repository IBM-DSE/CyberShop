class CreateMachineLearningServices < ActiveRecord::Migration
  def change
    create_table :machine_learning_services do |t|
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
