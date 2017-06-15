class DealsController < ApplicationController
  def index
    @deals = Deal.where special: false
  end
end
