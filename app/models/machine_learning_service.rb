class MachineLearningService < ApplicationRecord
  validate :get_deployments

  def get_deployments
    @service     = IBM::MachineLearning::Watson.new username, password
    @deployments = @service.get_deployments
  end

end
