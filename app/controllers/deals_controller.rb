class DealsController < ApplicationController
  def index
    @public_deals = Deal.where special: false
    @deals = Deal.where special: false
  end
end
