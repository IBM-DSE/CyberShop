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

        form action: admin_scoring_score_path, method: 'post' do
          fieldset class: 'inputs' do
            ol do
              deployment.get_input_schema.each do |param|
                li do
                  label param['name']
                  input param.slice('type', 'name')
                end
              end
            end
          end
          input 'Get Score', type: 'submit'
        end

      end
    end
  end
end
