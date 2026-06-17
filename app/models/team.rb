class Team < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :pagerduty_calendars, class_name: :PagerDutyCalendar
  has_many :manual_calendars,    class_name: :ManualCalendar
  has_and_belongs_to_many :services
  belongs_to :org_unit, optional: true

  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name description slug org_unit_id created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[pagerduty_calendars manual_calendars services org_unit]
  end

  def calendars
    pagerduty_calendars + manual_calendars
  end

  def slug_candidates
    %i[name]
  end

  def should_generate_new_friendly_id?
    true
  end

  def members
    calendars.flat_map(&:members).uniq
  end
end
