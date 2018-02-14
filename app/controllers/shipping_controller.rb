class ShippingController < ApplicationController
  def test
    @deployment = Deployment.where("name like ?", "%delay%").first
    @ml_scoring_params = @deployment.get_input_schema.map { |param|
      [param, MlScoringParam.find_by_name(param['name'])]
    }.to_h
  end
end
