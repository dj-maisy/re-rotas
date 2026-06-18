ActiveAdmin.register OrgUnit do
  permit_params :name, :slug, :parent_id

  controller do
    defaults :finder => :find_by_slug
  end
end
