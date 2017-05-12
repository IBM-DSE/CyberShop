ActiveAdmin.register MachineLearningService do
  permit_params :username, :password

  show do
    attributes_table do
      row :username
      row :password
    end
    machine_learning_service.deployments.each do |deployment|
      panel "Deployment #{deployment.id}" do

        attributes_table_for deployment do
          Deployment.display_columns.each do |attr|
            row attr
          end
        end

        render partial: 'admin/scoring/form', locals: {
          deployment_id: deployment.id,
          input_schema: deployment.get_input_schema
        }

      end
    end
  end
end
