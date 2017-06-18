class AddNameToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :name, :string
  end
end
