ActiveAdmin.register MlScoringParamOption do
  belongs_to :ml_scoring_param
  navigation_menu :ml_scoring_param
  permit_params :value
end
