# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::AvailableSlotsService do
  let(:service) { described_class.new(date: Time.utc(2022, 10, 25, 20, 10).to_s, duration: '60') }

  before do
    travel_to(Time.utc(2022, 10, 25, 20, 10))
  end

  describe 'when there are no exiting bookings' do
    let(:list) { service.list }

    it 'returns all time slots with 15 min range until end of the day' do
      expect(list.count).to eq(15)
    end

    it 'returns first time slot to next quarter hour' do
      expect(list.first[:slot]).to eq('20:15')
    end
  end

  describe 'when there are exiting bookings' do
    let(:list) { service.list }
    let!(:booking) do
      Booking.create(
        start: Time.utc(2022, 10, 25, 21, 0o0),
        end: Time.utc(2022, 10, 25, 22, 0o0)
      )
    end

    it 'returns first available booking after existing booking to prevent overlapping' do
      expect(list.first[:slot]).to eq('22:00')
    end

    it 'returns all available time slots with 15 min range until end of the day' do
      expect(list.count).to eq(8)
    end
  end
end
