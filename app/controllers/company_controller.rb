class CompanyController < ApplicationController
  def home
    @public_deals = Deal.where special: false
    @products = Product.first 8
  end

  def about
  end
end
