ActiveAdmin.register MlScoringParam do
  permit_params :name, ml_scoring_param_options_attributes: [:id, :value, :_destroy]

  sidebar 'Values', only: [:show] do
    ul do
      ml_scoring_param.ml_scoring_param_options.each do |option|
        li option.value
      end
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.has_many :ml_scoring_param_options, allow_destroy: true do |option|
        option.input :value
      end
    end
    f.actions
  end

end
