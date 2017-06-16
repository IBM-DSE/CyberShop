ActiveAdmin.register Customer do
  permit_params :gender, :age_group, :education, :profession, :income, :switcher, :last_purchase, :annual_spend

  form do |f|
    f.semantic_errors
    f.inputs :name, :email, :gender, :age_group, :education, :profession, :income, :switcher, :last_purchase, :annual_spend
    f.actions
  end
end
