ActiveAdmin.register Deployment do 
  permit_params :product_id, :machine_learning_service_id, :guid

  form do |f|
    f.semantic_errors
    f.inputs :product, :machine_learning_service, :guid
    f.actions
  end
  
end
