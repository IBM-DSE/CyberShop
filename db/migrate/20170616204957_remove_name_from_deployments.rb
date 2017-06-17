class RemoveNameFromDeployments < ActiveRecord::Migration
  def change
    remove_column :deployments, :name
    add_reference :deployments, :product, index: true
  end
end
