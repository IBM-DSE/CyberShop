ActiveAdmin.register TrendingTopic do
permit_params :name, :product_id

  index do
    selectable_column
    column :name
    column :product
    column :created_at
    column :updated_at
    actions
  end
  
end
