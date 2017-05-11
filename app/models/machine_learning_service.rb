class MachineLearningService < ApplicationRecord
  has_many :deployments
  validate :get_deployments

  def get_deployments
    @service = IBM::MachineLearning::Watson.new username, password
    begin
      deployments_list = @service.get_deployments
      deployments_list.each do |deployment|
        url = deployment['entity']['scoringHref']
        prefix = url[36..url.index('/', 36) - 1]
        deployments.build id:     deployment['metadata']['guid'],
                          name:   deployment['entity']['name'],
                          status: deployment['entity']['status'],
                          prefix: prefix,
                          created_at: deployment['metadata']['createdAt'],
                          updated_at: deployment['metadata']['modifiedAt']
      end
    rescue RuntimeError => e
      message = e.message == 'Net::HTTPUnauthorized' ? 'Authorization failure' : e.message
      errors.add(:username, message)
      errors.add(:password, message)
    end
  end

end
