# frozen_string_literal: true

module Services
  class AvailableSlotsService
    include Api::V1::BookingsHelper
    attr_reader :date, :duration

    def initialize(date:, duration:)
      @date = DateTime.parse(date).change(sec: 0)
      @duration = duration.to_i
    end

    def list
      available_slots
    end

    private

    def available_slots
      list = []

      slot_time = current_time.dup
      loop do
        list << { slot: slot_time.strftime('%H:%M') } unless booking_exist?(slot_time)
        slot_time += 15.minutes
        break if slot_time.to_date == date.to_date + 1.day
      end
      list
    end

    # used unix epoch timestamp to check if time overlaps because overlaps? works only for date
    # to_i converts time to an integer number of seconds since the Unix epoch
    def booking_exist?(time)
      Booking.where('start >= ? AND end <= ?', (current_time - 1.day), (current_time + 1.day).end_of_day).find_each do |booking|
        return true if booking_overlaps?(time, booking)
      end
      false
    end

    def booking_overlaps?(time, booking)
      start_time = time.dup.utc
      end_time = time.dup.utc + duration.minutes

      (start_time.to_i...end_time.to_i).overlaps?(booking.start.to_i...booking.end.to_i)
    end

    def current_time
      date.utc.today? ? time_to_next_quarter_hour(date) : date.beginning_of_day
    end
  end
end
