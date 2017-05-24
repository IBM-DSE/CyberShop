ActiveAdmin.register Product do
  permit_params :name, :category_id, :image

  form do |f|
    f.semantic_errors
    f.inputs :name, :category, :image
    f.actions
  end

  show do
    default_main_content
    panel 'Image' do
      image_tag product.image.url
    end
  end

end
