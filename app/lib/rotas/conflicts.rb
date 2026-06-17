module Rotas::Conflicts
  def self.find(annual_leave_events, calendars_day_and_events)
    # Optimisation: Calculate this ONCE rather than inside the loop for every calendar
    al_emails_by_day = annual_leave_emails_by_day(annual_leave_events)

    calendars_day_and_events.transform_values do |events_by_date|
      conflicts_for_calendar(al_emails_by_day, events_by_date)
    end
  end

  def self.conflicts_for_calendar(al_emails_by_day, cal_emails_by_day)
    (al_emails_by_day.keys | cal_emails_by_day.keys)
      .to_h { |date| get_conflicts(date, al_emails_by_day, cal_emails_by_day) }
      .reject { |_, intersection| intersection.empty? }
  end

  def self.annual_leave_emails_by_day(annual_leave_events)
    annual_leave_events
      .flat_map { |a| (a.start_date..a.end_date).map { |d| [d, a.email] } }
      .group_by { |d, _| d }
      .transform_values { |pairs| pairs.map { |_, v| v } }
  end

  def self.get_conflicts(date, al_emails_by_day, cal_emails_by_day)
    leave_emails = al_emails_by_day.fetch(date, [])
    cal_emails   = cal_emails_by_day.fetch(date, []).map(&:email)

    intersection = leave_emails & cal_emails

    [date, intersection]
  end

  private_class_method :get_conflicts
end
