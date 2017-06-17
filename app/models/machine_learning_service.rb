class MachineLearningService < ActiveRecord::Base
  has_many :deployments, dependent: :destroy
  validates :username, presence: true
  validates :password, presence: true
  # validate :get_deployments

  def get_deployments
    init_service
    begin
      deployments_list = @service.get_deployments['resources']
      deployments_list.each do |deployment|
        url    = deployment['entity']['scoringHref']
        prefix = url[36..url.index('/', 36) - 1]
        deployments.find_or_initialize_by guid: deployment['metadata']['guid'] do |d|
          d.name       = deployment['entity']['name']
          d.status     = deployment['entity']['status']
          d.prefix     = prefix
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

  def get_model(deployment_id)
    init_service
    @service.get_model deployment_id
  end

  def get_score(deployment_id, data, prefix=nil)
    init_service
    @service.get_score deployment_id, data
  end
  
  private
  
  def init_service
    if hostname
      @service = IBM::MachineLearning::Local.new hostname, username, password
    else
      @service = IBM::MachineLearning::Watson.new username, password
    end
  end

end
