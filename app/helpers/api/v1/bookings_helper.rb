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
        array = time.to_a
        quarter = ((array[1] % 60) / 15.0).ceil
        array[1] = (quarter * 15) % 60
        offset = quarter == 4 ? 3600 : 0
        (Time.zone.local(*array) + offset).change(offset: time.to_datetime.zone)
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
