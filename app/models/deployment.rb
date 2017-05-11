class Deployment < ApplicationRecord
  belongs_to :machine_learning_service

  def self.display_columns
    self.columns_hash.except('machine_learning_service_id').keys
  end
end
