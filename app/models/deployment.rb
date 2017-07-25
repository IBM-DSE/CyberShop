class Deployment < ActiveRecord::Base
  belongs_to :machine_learning_service
  belongs_to :product

  def self.display_columns
    self.columns_hash.except('machine_learning_service_id').keys
  end

  def get_input_schema
    model_result = machine_learning_service.get_model model_id
    model_result['entity']['input_data_schema']['fields']
  end

  def get_score(input)
    if machine_learning_service.hostname == 'ibm-watson-ml.mybluemix.net'
      machine_learning_service.get_score guid, input, model_id
    else
      data = use_tweets? ? { TWEETS: input.get_twitter_data[0] } : extract_attributes(input)
      if data.values.any?
        p data
        result = machine_learning_service.get_score guid, data
        score = result[offset][1]
        p score
        return score
      end
      0
    end
  end
  
  private

  CUSTOMER_ATTRIBUTES = %w(Gender AgeGroup Education Profession Income Switcher LastPurchase Annual_Spend)
  def extract_attributes(customer)
    CUSTOMER_ATTRIBUTES.map {|attr| [attr, customer[attr.underscore] ] }.to_h
  end
  
  def use_tweets?
    product.name == 'sPhone 8'
  end
  
  def offset
    product.name == 'sPhone 8' ? -2 : -4
  end
  
end
