ActiveAdmin.register Deal do
  permit_params :product_id, :description, :image
  
  form do |f|
    f.semantic_errors
    f.inputs :product, :description, :image
    f.actions
  end
  
end
