class CompanyController < ApplicationController
  def home
    @public_deals = Deal.where special: nil
  end

  def about
  end
end
