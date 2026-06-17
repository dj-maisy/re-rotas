require "test_helper"
require "minitest/mock"

class RotasCalendarTest < ActiveSupport::TestCase
  test "calendar shows current team members only" do
    mock_calendar_class = Class.new do
      include Rotas::Calendar

      def person_day_events
        [
          Rotas::PersonDayEvent.new(nil, "notcurrent", Date.today - 3),
          Rotas::PersonDayEvent.new(nil, "current", Date.today + 1),
        ]
      end
    end

    calendar = mock_calendar_class.new

    members = calendar.members

    assert_equal 1, members.length
    assert_equal "current", members.first
  end
end
