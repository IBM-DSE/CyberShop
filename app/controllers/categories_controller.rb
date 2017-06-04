class CategoriesController < ApplicationController
  def show
    @category = Category.find params[:id]
    redirect_to root_path, flash: { error: 'Could not find the category ' + params[:name] } unless @category
  end
end
