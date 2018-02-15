class ShippingController < ApplicationController
  
  @@deployment = Deployment.where("name like ?", "%delay%").first

  # get a mapping of input schema param name to type
  @@schema_params = @@deployment&.get_input_schema&.map { |param|
    rec = MlScoringParam.find_by_name(param['name'])
    [param['name'], {
      type: param['metadata']['columnInfo']['columnTypeName'],
      name: rec&.alias ? rec.alias : key,
      record: rec
    }]
  }.to_h
  
  def test
    @schema_params = @@schema_params
    @shipment = session[:shipment]
  end
  
  def score
    
    # convert integer type params to integers
    @input = {}
    scoring_params.each do |param, val|
      @input[param] = case @@schema_params[param][:type]
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
      @input.transform_keys! do |key|
        rec = MlScoringParam.find_by_name(key)
        rec&.alias ? rec.alias : key
      end
      @output     = score.except(*@input.keys)
      @prediction = @output['values'][0].last
  
      @color = case
                 when @prediction < 1 then
                   'green'
                 when @prediction < 2 then
                   'gold'
                 else
                   'red'
               end
      
    else
      redirect_to :shipping_test, flash: { error: 'ERROR: There is no available model for predicting shipping delay' }
    end
    
  end
  
  private
  
  def scoring_params
    params.permit(@@schema_params.keys)
  end
  
end
