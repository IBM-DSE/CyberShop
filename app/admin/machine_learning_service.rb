ActiveAdmin.register MachineLearningService do
  permit_params :username, :password

  show do
    default_main_content do
      row :deployments do
        # machine_learning_service.get_deps
      end
    end
  end
end
