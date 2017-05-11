class MachineLearningService < ApplicationRecord
  validate :get_deployments

  attr_reader :deployments

  def get_deployments
    @service = IBM::MachineLearning::Watson.new username, password
    begin
      puts @service.get_deployments
    rescue RuntimeError => e
      message = e.message == 'Net::HTTPUnauthorized' ? 'Authorization failure' : e.message
      errors.add(:username, message)
      errors.add(:password, message)
    end
  end

end
