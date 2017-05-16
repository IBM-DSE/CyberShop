ActiveAdmin.register MlScoringParam do
  permit_params :file, :name, ml_scoring_param_options_attributes: [:id, :value, :_destroy]

  index do
    column :name
    column :ml_scoring_param_options
    actions
  end

  collection_action :upload_csv

  collection_action :import_csv, method: :post do
    MlScoringParam.import params[:file]
    redirect_to collection_path, notice: 'CSV imported successfully!'
  end

  show do
    attributes_table do
      row :name
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
      f.has_many :ml_scoring_param_options, allow_destroy: true do |option|
        option.input :value
      end
    end
    f.actions
  end

end
