# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::BookingsHelper, type: :helper do
  describe '#booking_durations' do
    it 'returns booking durations which can be selected' do
      expect(helper.booking_durations.first).to eq({ duration: 15, duration_humanized: '15 minutes' })
    end
  end

  describe '#time_to_next_quarter_hour' do
    it 'returns datetime with next quarter and correct hour' do
      expect(helper.time_to_next_quarter_hour(Time.utc(2022, 10, 25, 20, 10).to_datetime).strftime('%H:%M')).to eq('20:15')
      expect(helper.time_to_next_quarter_hour(Time.utc(2022, 10, 25, 20, 58).to_datetime).strftime('%H:%M')).to eq('21:00')
    end
  end
end
