# frozen_string_literal: true

module Services
  class BookingService
    attr_reader :duration, :date, :slot
    attr_accessor :booking

    def initialize(params)
      @duration = params[:duration].to_i
      @date = DateTime.parse(params[:date])
      @slot = params[:slot]
    end

    def create
      create_booking
    end

    private

    def create_booking
      @booking = Booking.new(start: booking_date, end: booking_date + duration.minutes)
      booking.save
    end

    def booking_date
      hour, minute = slot.split(':')
      date.change(hour: hour.to_i, min: minute.to_i)
    end
  end
end
