class ProductsController < ApplicationController
  before_action :init_cart_if_empty
  
  def show
    @product = Product.find params[:id]
    combo_deals = @product.trigger_deals.where(special: false)
    if combo_deals.first
      @additional_product = combo_deals.first.product
      @discount_price = combo_deals.first.price
    end
    @deals = (combo_deals << @product.deal).compact
    @in_cart = session[:cart].include? @product.friendly_id
    p @in_cart
  end

  def add_multiple_to_cart
    @additional_product = Product.find order_products_params[:additional_product] if order_products_params[:additional_product]
    session[:cart] << @additional_product.friendly_id if @additional_product
    add_to_cart and return
  end

  def add_to_cart
    @product = Product.find order_products_params[:id]
    session[:cart] << @product.friendly_id
    # @product.check_special_offer current_customer
    redirect_to action: 'cart'
  end

  def remove_from_cart
    session[:cart].delete params[:id]
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
    session[:cart] = [] unless session[:cart]
  end
  
  def order_products_params
    params.permit(:id, :additional_product)
  end
  
end
