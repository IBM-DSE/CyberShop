ActiveAdmin.register_page 'Scoring' do

  controller do

    def score

      deployment     = Deployment.find(params[:deployment_id])

      # get a mapping of input schema param name to type
      schema_params   = deployment.get_input_schema.map do |param|
        [param['name'], param['type']]
      end.to_h

      # extract the valid parameters using the keys of this mapping
      valid_params    = scoring_params(schema_params.keys)

      # convert integer type params to integers
      cleansed_values = valid_params.to_h.map do |name, val|
        schema_params[name] == 'integer' ? val.to_i : val
      end


      # get the score
      score          = deployment.get_score cleansed_values

      @input = valid_params.to_h
      @input.transform_keys! do |key|
        rec = MlScoringParam.find_by_name(key)
        rec&.alias ? rec.alias : key
      end
      @output = score.except(*@input.keys)

    end

    def scoring_params schema_params
      params.permit(schema_params)
    end

  end

end
