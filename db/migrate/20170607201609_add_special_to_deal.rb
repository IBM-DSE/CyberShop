class AddSpecialToDeal < ActiveRecord::Migration
  def change
    add_column :deals, :special, :boolean
  end
end
