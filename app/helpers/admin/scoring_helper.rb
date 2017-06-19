module Admin::ScoringHelper
  def type in_type
    {
      'string'  => 'text',
      'integer' => 'number',
      'decimal' => 'number'
    }[in_type]
  end

  def scoring_input(hash, record)
    if !record or record.ml_scoring_param_options.empty?
      text_field_tag hash['name'], nil, type: type(hash['type'].split('(')[0])
    else
      select_tag hash['name'],
                 options_from_collection_for_select(record.ml_scoring_param_options,
                                                    :value,
                                                    :value)
    end
  end
end
