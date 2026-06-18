ActiveAdmin.register Service do
  permit_params :name, :description, :documentation, :slug

  controller do
    defaults :finder => :find_by_slug
  end
end
