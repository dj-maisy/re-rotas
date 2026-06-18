ActiveAdmin.register Team do
  permit_params :name, :description, :slug, :org_unit_id

  controller do
    defaults :finder => :find_by_slug
  end
end
