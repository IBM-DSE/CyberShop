class BrandsController < ApplicationController
  def show
    @brand = Brand.find params[:id]
    redirect_to root_path, flash: { error: 'Could not find the brand ' + params[:name] } unless @brand
  end
end
