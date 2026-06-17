require "http"
require "icalendar"
require "securerandom"

class PagerDutyCalendar < ApplicationRecord
  self.primary_key = "id"

  belongs_to :team

  include Rotas::Calendar

  validates :name, presence: true
  validates :url,  presence: true

  validates :clock_type,
            presence: true,
            inclusion: { in: %w[in_hours out_of_hours in_and_out_of_hours] }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id team_id name url clock_type created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[team]
  end

  validate :url_is_http

  def url_is_http
    errors.add(:url, "expected http(s) calendar address") unless /^https?:/i.match?(url)
  end

  def events
    calendar = Icalendar::Calendar.parse(
      StringIO.new(Rotas::URL_CACHE.fetch(url)),
    )

    calendar
      .flat_map(&:events)
      .map do |icalendar_event|
        start_date = icalendar_event.dtstart.to_date
        end_date   = icalendar_event.dtend.to_date
        emails     = icalendar_event.attendee.map(&:to_s)
        Rotas::Event.new(self, emails, start_date, end_date)
      end
  end

  def events_editable?
    false
  end

  before_create :generate_pd_id

  def generate_pd_id
    self.id = "pagerduty:#{SecureRandom.uuid}"
  end
end
