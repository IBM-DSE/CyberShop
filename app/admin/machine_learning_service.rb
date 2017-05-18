ActiveAdmin.register MachineLearningService do
  permit_params :name, :username, :password
  
  index do
    column 'Service' do |service|
      link_to service.name || service.id, admin_machine_learning_service_path(service)
    end
    column :username
    column :created_at
    column :updated_at
    actions
  end
  
  show do
    attributes_table do
      row :username
      row :password { '******' }
    end
    machine_learning_service.deployments.each do |deployment|
      panel "Deployment #{deployment.id}" do

        table do
          tr do
            td do
              attributes_table_for deployment do
                Deployment.display_columns.each do |attr|
                  row attr
                end
              end
            end

            td do
              h3 'Test Scoring'
              render partial: 'admin/scoring/form', locals: {
                deployment_id: deployment.id,
                input_schema:  deployment.get_input_schema
              }
              if defined? score
                h3 'Scoring Result'
                score
              end
            end
          end
        end

      end
    end
  end
end
