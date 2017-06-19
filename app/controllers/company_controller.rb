class CompanyController < ApplicationController
  def home
    @deal = Deal.where(special: false).first
    @products = Product.first 8
  end

  def about
  end
end
