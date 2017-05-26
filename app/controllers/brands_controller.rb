class BrandsController < ApplicationController
  def show
    @brand = Brand.find_by_name params[:name]
    redirect_to root_path, flash: { error: 'Could not find the brand ' + params[:name] } unless @brand
  end
end
