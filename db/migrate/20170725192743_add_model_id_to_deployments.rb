class AddModelIdToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :model_id, :string
  end
end
