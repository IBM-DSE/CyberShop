class MachineLearningService < ActiveRecord::Base
  has_many :deployments, dependent: :destroy
  validate :get_deployments

  def get_deployments
    init_service
    if @service.class == IBM::ML::Cloud
      self.hostname = 'ibm-watson-ml.mybluemix.net'
      begin
        deployments_list = @service.deployments['resources']
        deployments_list.each do |deployment|
          deployments.find_or_initialize_by guid: deployment['metadata']['guid'] do |d|
            d.name       = deployment['entity']['name']
            d.status     = deployment['entity']['status']
            d.model_id   = deployment['entity']['published_model']['guid']
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
  end

  def get_model(model_id)
    init_service
    @service.model model_id
  end

  def get_score(deployment_id, data, model_id=nil)
    init_service
    if @service.class == IBM::ML::Local
      @service.score deployment_id,data
    elsif @service.class == IBM::ML::Cloud
      @service.score deployment_id, data
    end
  end
  
  def is_cloud?
    hostname == 'ibm-watson-ml.mybluemix.net'
  end
  
  private
  
  def init_service
    if is_cloud?
      @service = IBM::ML::Cloud.new username, password
    else
      @service = IBM::ML::Local.new hostname, username, password
    end
  end

end
