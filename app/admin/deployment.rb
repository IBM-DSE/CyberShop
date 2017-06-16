ActiveAdmin.register Deployment do 
  permit_params :machine_learning_service_id, :guid, :name

  form do |f|
    f.semantic_errors
    f.inputs :machine_learning_service, :guid, :name
    f.actions
  end
  
end
