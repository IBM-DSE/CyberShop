class MachineLearningService < ApplicationRecord
  has_many :deployments, dependent: :destroy
  validates :username, presence: true
  validates :password, presence: true
  validate :get_deployments

  def get_deployments
    @service = IBM::MachineLearning::Watson.new username, password
    begin
      deployments_list = @service.get_deployments['resources']
      deployments_list.each do |deployment|
        deployments.find_or_initialize_by id: deployment['metadata']['guid'] do |d|
          d.name       = deployment['entity']['name']
          d.status     = deployment['entity']['status']
          d.prefix     = deployment['entity']['scoringHref'][36..url.index('/', 36) - 1]
          d.created_at = deployment['metadata']['createdAt']
          d.updated_at = deployment['metadata']['modifiedAt']
        end
      end
    rescue RuntimeError => e
      message = e.message == 'Net::HTTPUnauthorized' ? 'Authorization failure' : e.message
      errors.add(:username, message)
      errors.add(:password, message)
    end
  end

  def get_model deployment_id
    @service = IBM::MachineLearning::Watson.new username, password
    @service.get_model deployment_id
  end

  def get_score prefix, deployment_id, record
    @service = IBM::MachineLearning::Watson.new username, password
    @service.get_score prefix, deployment_id, record
  end

end
