class ShippingController < ApplicationController
  
  def test
    @schema_params = SHIPPING_PARAMS
    @shipment = session[:shipment]
  end
  
  def score
    
    # convert integer type params to integers
    @input = {}
    scoring_params.each do |param, val|
      @input[param] = case SHIPPING_PARAMS[param][:type]
                                when 'integer'
                                  val.to_i
                                when 'decimal'
                                  val.to_f
                                else
                                  val
                              end
    end
    
    if @@deployment
      # get the score
      score = @@deployment.score @input
      session[:shipment] = @input.dup
  
      # generate view variables
      @input = ShippingController.reorder(@input, SHIPPING_PARAMS_ORDER)
      @input.transform_keys! do |key|
        rec = MlScoringParam.find_by_name(key)
        rec&.alias ? rec.alias : key
      end
      @prediction = score['values'][0].last
      @arrival_date = Date.today + 1 + @input['Distance (km)'] / 1000 + @prediction.round(2)
      p @arrival_date
  
      @color = case
                 when @prediction < 1 then
                   'green'
                 when @prediction < 2 then
                   'gold'
                 else
                   'red'
               end
      
    else
      redirect_to :shipping, flash: { error: 'ERROR: There is no available model for predicting shipping delay' }
    end
    
  end
  
  private
  
  def scoring_params
    params.permit(SCHEMA_PARAMS_ORDER)
  end
  
  @@deployment = Deployment.where("name like ?", "%delay%").first
  
  SHIPPING_PARAMS_ORDER = ['totalCases', 'totalWeight', 'shipFrom', 'shipFromState',
                           'shipTo', 'shipToState', 'distance', 'destWeatherConds']
  
  def self.reorder(hash, order)
    new_hash = {}
    order.each do |key|
      new_hash[key] = hash[key]
    end
    new_hash
  end
  
  # get a mapping of input schema param name to type

  schema_params = @@deployment&.get_input_schema&.map { |param|
    rec = MlScoringParam.find_by_name(param['name'])
    [param['name'], {
      type: param['metadata']['columnInfo']['columnTypeName'],
      name: rec&.alias ? rec.alias : key,
      record: rec
    }]
  }.to_h

  SCHEMA_PARAMS_ORDER = schema_params.keys
  
  SHIPPING_PARAMS = ShippingController.reorder(schema_params, SHIPPING_PARAMS_ORDER)
  
end
