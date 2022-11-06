# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::BookingService do
  let(:service) { described_class.new(date: Time.utc(2022, 10, 25, 20, 10).to_s, duration: '60', slot: '21:00') }

  before do
    travel_to(Time.utc(2022, 10, 25, 20, 10))
  end

  describe 'when there are no exiting bookings' do
    it 'returns true and creates booking' do
      expect(service.create).to be(true)
      expect(Booking.count).to eq(1)
    end
  end

  describe 'when there are exiting bookings' do
    let!(:booking) do
      Booking.create(
        start: Time.utc(2022, 10, 25, 21, 0o0),
        end: Time.utc(2022, 10, 25, 22, 0o0)
      )
    end

    it 'returns false and doesn\'t create booking' do
      expect(service.create).to be(false)
      expect(service.booking.errors.full_messages.first).to eq('Start overlaps with an existing booking')
    end
  end
end
