class ManualCalendarEvent < ApplicationRecord
  belongs_to :manual_calendar

  validates :start_date, presence: true
  validates :end_date,   presence: true
  validate :end_date_after_start_date?

  serialize :emails, Array

  def self.ransackable_attributes(auth_object = nil)
    %w[id manual_calendar_id start_date end_date created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[manual_calendar]
  end

private

  def end_date_after_start_date?
    if start_date && end_date && end_date < start_date
      errors.add :end_date, "must be equal to, or later than start date"
    end
  end
end
