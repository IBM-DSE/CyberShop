ActiveAdmin.register Product do
  permit_params :name, :category_id, :brand_id, :image, :preorder

  form do |f|
    f.semantic_errors
    f.inputs :name, :category, :brand, :image, :price, :preorder
    f.actions
  end

  show do
    default_main_content
    panel 'Image' do
      image_tag product.image.url
    end
  end

end
