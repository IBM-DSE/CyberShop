class ProductsController < ApplicationController
  def show
    @product = Product.find params[:id]
  end
  
  def add_to_cart
    @product = Product.find params[:id]
    init_cart_if_empty
    session[:cart] << @product.id
    redirect_to action: 'cart'
  end
  
  def cart
    init_cart_if_empty
    @cart = Product.find session[:cart]
    @special_deal = @cart.collect(&:special_deal).compact[0]
  end
  
  private
  
  def init_cart_if_empty
    session[:cart] = [] unless session[:cart]
  end
  
end
