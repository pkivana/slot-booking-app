# frozen_string_literal: true

module Api
  module V1
    module BookingsHelper
      def booking_durations
        durations = []
        1.upto(40) do |i|
          duration =  15 * i
          durations << { duration: duration, duration_humanized: humanize_duration(duration) }
        end
        durations
      end

      def time_to_next_quarter_hour(time)
        quarter = ((time.min % 60) / 15.0).ceil
        min = (quarter * 15) % 60
        offset = quarter == 4 ? 60 : 0

        time.change(min: min) + offset.minutes
      end

      private

      def humanize_duration(duration)
        minutes = duration % 60
        hours = duration / 60
        return "#{minutes} minutes" if hours.zero?

        hours_humanized = "#{hours} #{'hour'.pluralize(hours)}"
        return hours_humanized if minutes.zero?

        hours_humanized + " and #{minutes} minutes"
      end
    end
  end
end
