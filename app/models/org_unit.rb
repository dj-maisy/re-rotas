class OrgUnit < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :teams
  has_many :services, through: :teams

  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name slug created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[teams services]
  end
end
