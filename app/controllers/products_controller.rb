class ProductsController < ApplicationController
  before_action :init_cart_if_empty


  def show
    @product = Product.find params[:id]
    @deals   = @product.trigger_deals.where(special: false) << @product.deal
    @deals.compact!
    @in_cart = session[:cart].include? @product.id
  end


  def add_multiple_to_cart
    if order_products_params[:additional_product]
      additional_product = Product.find order_products_params[:additional_product]
      put_in_cart additional_product if additional_product
    end
    add_to_cart
  end


  def add_to_cart
    @product = Product.find order_products_params[:id]
    put_in_cart @product if @product
    check_new_deals
    redirect_to action: 'cart'
  end


  def remove_from_cart
    product = Product.find params[:id]
    session[:cart].delete product.id
    change_cart_price(-1*product.price)
    check_removed_deals
    redirect_to action: 'cart'
  end


  def cart
    @cart = Product.find session[:cart]
    apply_discounts

    # Check for any special offers
    if customer_signed_in?
      @cart.each do |product|
        @offered_deal ||= product.check_special_offer(current_customer)
      end
    end
  end


  private


  def check_new_deals
    Product.find(session[:cart]).each do |product|
      deal = product.deal
      if deal and !session[:deals].include?(deal.id)
        if deal.trigger_product.nil? or session[:cart].include?(deal.trigger_product.id)
          session[:deals] << deal.id
          change_cart_price -1*discount(deal)
        end
      end
    end
  end


  def apply_discounts
    session[:deals].each do |deal_id|
      deal                      = Deal.find deal_id
      idx                       = @cart.index deal.product
      @cart[idx].discount_price = deal.price if idx
    end
  end


  def check_removed_deals
    Deal.find(session[:deals]).each do |deal|
      if deal.trigger_product and (session[:cart] & [deal.trigger_product.id, deal.product.id]).length < 2 or not session[:cart].include? deal.product
        session[:deals].delete deal.id
        change_cart_price discount(deal)
      end
    end
  end


  def discount(deal)
    deal.product.price - (deal.price || 0)
  end


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
    unless session[:cart].include? product.id
      session[:cart] << product.id
      change_cart_price(product.discount_price || product.price)
    end
  end


  def change_cart_price(price)
    session[:cart_price] = BigDecimal.new(session[:cart_price]) + price
  end


end
