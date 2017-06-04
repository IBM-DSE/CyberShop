class CompanyController < ApplicationController
  def home
    @preorders = Product.where preorder: true
  end

  def about
  end
end
