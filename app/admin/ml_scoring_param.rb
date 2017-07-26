ActiveAdmin.register MlScoringParam do
  permit_params :file, :name, :alias, ml_scoring_param_options_attributes: [:id, :value, :_destroy]

  index do
    selectable_column
    column :name
    column :alias
    column :ml_scoring_param_options
    actions
  end

  collection_action :upload_csv

  collection_action :import_csv, method: :post do
    MlScoringParam.import params[:file], params[:aliases]
    redirect_to collection_path, notice: 'CSV imported successfully!'
  end

  action_item :upload_csv, only: :index do
    link_to 'Upload CSV data', upload_csv_admin_ml_scoring_params_path
  end

  show do
    attributes_table do
      row :name
      row :alias
      row :options do
        table_for ml_scoring_param.ml_scoring_param_options do
          column :value
        end
      end
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :alias
      f.has_many :ml_scoring_param_options, allow_destroy: true do |option|
        option.input :value
      end
    end
    f.actions
  end

end
