module ScoringHelper
  def type in_type
    {
      'string'  => 'text',
      'integer' => 'number',
      'decimal' => 'number'
    }[in_type]
  end

  def scoring_input param
    selectable_param = MlScoringParam.find_by_name(param['name'])
    if !selectable_param
      text_field_tag param['name'], nil, type: type(param['type'].split('(')[0])
    else
      select_tag param['name'],
                 options_from_collection_for_select(selectable_param.ml_scoring_param_options,
                                                    :value,
                                                    :value)
    end
  end
end
