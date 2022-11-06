# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Booking, type: :model do
  let(:booking) do
    described_class.new(
      start: Time.utc(2022, 11, 1, 10, 30),
      end: Time.utc(2022, 11, 1, 12, 30)
    )
  end
  let(:booking2) do
    described_class.new(
      start: Time.utc(2022, 11, 1, 11, 30),
      end: Time.utc(2022, 11, 1, 12, 30)
    )
  end

  before do
    travel_to(DateTime.new(2022, 10, 25))
  end

  it 'is valid with valid attributes' do
    expect(booking).to be_valid
  end

  it 'is not valid without a start' do
    booking.start = nil
    expect(booking).not_to be_valid
  end

  it 'is not valid without a end' do
    booking.end = nil
    expect(booking).not_to be_valid
  end

  it 'is not valid when start is in the past' do
    booking.start = 1.day.ago
    expect(booking).not_to be_valid
  end

  it 'is not valid when end is in the past' do
    booking.end = 1.day.ago
    expect(booking).not_to be_valid
  end

  it 'is not valid when booking overlaps' do
    booking2.save
    expect(booking).not_to be_valid
  end
end
