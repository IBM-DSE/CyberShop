class AddTriggerProductToDeals < ActiveRecord::Migration
  def change
    add_reference :deals, :trigger_product, index: true, foreign_key: true
  end
end
