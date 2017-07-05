class DealsController < ApplicationController
  def index
    @public_deals = Deal.where special: false
    @deals = Deal.where(special: false).where.not(trigger_product_id: nil)
  end
end
