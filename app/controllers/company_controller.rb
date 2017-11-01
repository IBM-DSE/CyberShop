class CompanyController < ApplicationController
  def home
    @deal = Deal.where(special: false).first
    @products = Product.where.not(id: @deal.product.id).where.not(name: 'aBook Air').first 8
  end

  def about
  end
end
