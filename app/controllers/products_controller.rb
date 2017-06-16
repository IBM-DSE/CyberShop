class ProductsController < ApplicationController
  before_action :init_cart_if_empty

  def show
    @product = Product.find params[:id]
    @deals   = @product.trigger_deals.where(special: false) << @product.deal
    @deals.compact!
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
    final_price = check_discount(product)
    change_cart_price(-1*final_price)
    redirect_to action: 'cart'
  end

  def cart
    
    @cart = session[:cart].map {|id| Product.find id}

    # Check for any special offers
    if customer_signed_in?
      @cart.each do |product|
        @offered_deal = product.check_special_offer(current_customer)
      end
    end
    
  end

  private

  def init_cart_if_empty
    unless session[:cart]
      session[:cart]       = []
      session[:deals]      = []
      session[:cart_price] = 0
    end
  end

  def order_products_params
    params.permit(:id, :additional_product)
  end

  def put_in_cart(product)
    unless session[:cart].include? product.friendly_id
      session[:cart] << product.friendly_id
      change_cart_price(product.discount_price || product.price)
    end
  end

  def change_cart_price(price)
    session[:cart_price] = BigDecimal.new(session[:cart_price]) + price
  end

  def offered_deals
    trigger_deals = @cart.collect(&:trigger_deals).flatten.compact
    offered_deals = []
    trigger_deals.each do |deal|
      idx = @cart.index deal.product
      if idx
        @cart[idx].discount_price = deal.price
        unless session[:deals].include? deal.id
          session[:deals] << deal.id
          change_cart_price deal.price - deal.product.price
        end
      else
        offered_deals << deal
      end
    end
    offered_deals
  end

  def check_discount(product)
    Deal.where(id: session[:deals]).each do |deal|
      if deal.trigger_product == product
        session[:deals].delete deal.id
        change_cart_price deal.product.price - deal.price
      elsif deal.product == product
        return deal.price
      end
    end
    product.price
  end

end
