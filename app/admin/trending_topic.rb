ActiveAdmin.register TrendingTopic do 
  permit_params :name, :product_id
  config.sort_order = 'frequency_desc'

  index do
    selectable_column
    column :name
    column :frequency
    column :aphone
    column :sphone
    column :product
    column :created_at
    column :updated_at
    actions
  end
  
end
