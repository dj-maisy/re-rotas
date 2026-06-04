class AuditEvent < ApplicationRecord
  validates :email, presence: true

  validates_each :event do |record, attr, val|
    if attr == :event && !val.is_a?(Hash) && !val.key?(:message)
      record.errors.add(attr, "must include a :message in the event")
    end
  end

  serialize :event, Hash

  def self.ransackable_attributes(auth_object = nil)
    %w[id email event created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
