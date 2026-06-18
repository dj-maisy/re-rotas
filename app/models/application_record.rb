class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Allow Ransack to search across all columns
  def self.ransackable_attributes(auth_object = nil)
    column_names + _ransackers.keys
  end

  # Allow Ransack to search across all associations
  def self.ransackable_associations(auth_object = nil)
    reflect_on_all_associations.map { |a| a.name.to_s }
  end
end
