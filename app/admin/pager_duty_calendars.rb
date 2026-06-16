ActiveAdmin.register PagerDutyCalendar do
  permit_params :team_id, :name, :url, :clock_type
end
