ActiveAdmin.register Product do
  permit_params :price, :name, :description, :published, :image
  
  index do
    selectable_column
    id_column
    column :name
    column :price
    column :description
    column :published
    actions
  end

  filter :name
  filter :price
  filter :description
  filter :published

  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :description
      f.input :published
      f.input :image, as: :file
    end
    f.actions
  end
  
end
