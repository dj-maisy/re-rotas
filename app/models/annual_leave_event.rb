class AnnualLeaveEvent < ApplicationRecord
  validates :email,      presence: true
  validates :start_date, presence: true
  validates :end_date,   presence: true
  validate :end_date_after_start_date?

  def self.ransackable_attributes(_auth_object = nil)
    %w[id email start_date end_date created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end

private

  def end_date_after_start_date?
    if start_date && end_date && end_date < start_date
      errors.add :end_date, "must be equal to, or later than start date"
    end
  end
end
