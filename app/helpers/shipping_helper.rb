module ShippingHelper
  
  SMALL = 7
  LARGE = 14
  SPACE = 1
  
  def shipping_input (param, hash, value)
    
    location = param.include? 'ship'
    weather = param.include? 'Weather'
    paren_content = param == 'totalCases' ? 'items' : hash[:name][/\((\w+)\)/,1]
    size = paren_content == 'State' ? SMALL : LARGE
    input_group = paren_content == 'Country' || weather ? {} : {class: "input-group"}
    
    content_tag :div, style: "flex: #{size};" do
  
      content_tag :div, input_group do
    
        if param.include? 'State'
          concat content_tag :span, paren_content, class: "input-group-addon"
        end
    
        if hash[:record].ml_scoring_param_options.empty?
          concat text_field_tag param, value, type: type(hash[:type].split('(')[0]), class: 'form-control'
    
        else
          concat select_tag param,
                            options_from_collection_for_select(hash[:record].ml_scoring_param_options,
                                                               :value, :value, value),
                            class: 'form-control'
        end
    
        unless location or weather
          concat content_tag :span, paren_content, class: "input-group-addon"
        end
  
      end
      
    end
    
  end
  
  def spacing (param)
  
    unless param.include? 'State'
      size = param.include?('Weather') ? SMALL+SPACE : LARGE
      size = SPACE if param.include? 'ship'
      content_tag(:div, nil, style: "flex: #{size};")
    end
    
  end
  
  def addon param, units, input
    if param.include? 'Ship'
      state = input["#{param}(State)"]
      ", #{state}" unless state == 'NA' 
    else
      units
    end
  end
  
end
