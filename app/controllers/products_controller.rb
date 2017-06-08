class ProductsController < ApplicationController
  def show
    @product = Product.find params[:id]
    @deals = (@product.trigger_deals.where(special: false) << @product.deal).compact
    @in_cart = session[:cart].include? @product.id
  end
  
  def add_to_cart
    @product = Product.find params[:id]
    init_cart_if_empty
    session[:cart] << @product.friendly_id
    redirect_to action: 'cart'
  end

  def remove_from_cart
    init_cart_if_empty
    session[:cart].delete params[:id]
    redirect_to action: 'cart'
  end
  
  def cart
    init_cart_if_empty
    @cart = session[:cart].map { |id| Product.find id } 
    trigger_deals = @cart.collect(&:trigger_deals).flatten.compact
    offered_deals = []
    trigger_deals.each do |deal|
      idx = @cart.index deal.product
      if idx
        @cart[idx].discount_price = deal.price
      else
        offered_deals << deal
      end
    end
    @special_deal = offered_deals[0]
  end
  
  private
  
  def init_cart_if_empty
    session[:cart] = [] unless session[:cart]
  end
  
end
