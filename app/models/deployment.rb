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

  def get_score(customer)
    puts
    puts "Getting #{product.name} prediction for #{customer.name}"
    result = Util.initialize_score(customer)
    
    data = input_data(customer)
    if data.values.any?
      begin
        Timeout::timeout(1) do
          result = score(data)
        end
        puts 'Scoring Successful!'
      rescue Exception => e
        STDERR.puts "#{e.class}: #{e.message}"
        puts
        puts 'Backup...'
      end
      puts
      puts 'Scoring Output:'
      p result
      probability = Util.extract(result)[:probability]
      puts "Probability = #{probability}"
      return probability
    end
    0
  end
  
  def score(data)
    puts "Scoring against #{guid}"
    puts 'Scoring Input:'
    puts JSON.pretty_unparse(data)
    if machine_learning_service.is_cloud?
      machine_learning_service.get_score guid, data, model_id
    else
      machine_learning_service.get_score guid, data
    end
  end
  
  def input_data(input)
    use_tweets? ? { TWEETS: input.get_twitter_data[0] } : extract_attributes(input)
  end
  
  private

  CUSTOMER_ATTRIBUTES = %w(Gender AgeGroup Education Profession Income Switcher LastPurchase Annual_Spend)
  def extract_attributes(customer)
    CUSTOMER_ATTRIBUTES.map {|attr| [attr.upcase, customer[attr.underscore] ] }.to_h
  end
  
  def use_tweets?
    product.name == 'sPhone 8'
  end
  
  def offset
    product.name == 'sPhone 8' ? -2 : -4
  end
  
end
