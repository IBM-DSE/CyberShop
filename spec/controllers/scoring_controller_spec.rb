require 'rails_helper'

RSpec.describe ScoringController, type: :controller do

  describe "GET #score" do
    it "returns http success" do
      get :score
      expect(response).to have_http_status(:success)
    end
  end

end
