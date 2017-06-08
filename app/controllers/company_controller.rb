class CompanyController < ApplicationController
  def home
    @public_deals = Deal.where special: false
  end

  def about
  end
end
