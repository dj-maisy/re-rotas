ActiveAdmin.register Service do
  permit_params :name, :description, :documentation, :slug
end
