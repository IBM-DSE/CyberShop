class AddGuidToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :guid, :string
  end
end
