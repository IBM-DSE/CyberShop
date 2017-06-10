class AddInterestToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :interest, :string
  end
end
