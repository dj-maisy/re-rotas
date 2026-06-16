ActiveAdmin.register Team do
  permit_params :name, :description, :slug, :org_unit_id
end
