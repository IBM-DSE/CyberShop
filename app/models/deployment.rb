class Deployment < ActiveRecord::Base
  belongs_to :machine_learning_service

  def self.display_columns
    self.columns_hash.except('machine_learning_service_id').keys
  end

  def get_input_schema
    model_result = machine_learning_service.get_model id
    model_result['entity']['inputDataSchema']['fields']
  end

  def get_score record
    machine_learning_service.get_score prefix, id, record
  end
end
