class ProductsController < ApplicationController
  before_action :init_cart_if_empty
  
  def show
    @product = Product.find params[:id]
    combo_deals = @product.trigger_deals.where(special: false)
    # if combo_deals.first
    #   additional_product = combo_deals.first.product
    #   @discount_price = combo_deals.first.price
    # end
    @deals = (combo_deals << @product.deal).compact
    @in_cart = session[:cart].include? @product.friendly_id
  end

  def add_multiple_to_cart
    if order_products_params[:additional_product]
      additional_product = Product.find order_products_params[:additional_product]
      put_in_cart additional_product if additional_product
    end
    add_to_cart and return
  end

  def add_to_cart
    @product = Product.find order_products_params[:id]
    put_in_cart @product if @product
    redirect_to action: 'cart'
  end

  def remove_from_cart
    product = Product.find params[:id]
    session[:cart].delete params[:id]
    change_cart_price(product.price, false)
    redirect_to action: 'cart'
  end
  
  def cart
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
    unless session[:cart]
      session[:cart] = []
      session[:cart_price] = 0
    end
  end
  
  def order_products_params
    params.permit(:id, :additional_product)
  end
  
  def put_in_cart(product)
    session[:cart] << product.friendly_id
    change_cart_price(product.price)
  end
  
  def change_cart_price(price, increment=true)
    session[:cart_price] = BigDecimal.new(session[:cart_price]) + (increment ? 1 : -1)*price
  end
  
end
