class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_name params[:name]
    redirect_to root_path, flash: { error: 'Could not find the category ' + params[:name] } unless @category
  end
end
