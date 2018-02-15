module ShippingHelper
  
  def shipping_input (param, hash, value)
    
    if hash[:record].ml_scoring_param_options.empty?
      text_field_tag param, value, type: type(hash[:type].split('(')[0]), class: 'form-control'
    
    else
      select_tag param,
                 options_from_collection_for_select(hash[:record].ml_scoring_param_options,
                                                    :value, :value, value),
                 class: 'form-control'
    end
  end
  
end
