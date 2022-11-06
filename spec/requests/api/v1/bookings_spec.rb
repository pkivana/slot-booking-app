# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Bookings', type: :request do
  before do
    travel_to(DateTime.new(2022, 10, 25))
  end

  describe 'POST /create' do
    it 'returns http success' do
      post '/api/v1/bookings', params: { duration: '60', date: Time.utc(2022, 11, 1, 10, 30).to_s, slot: '10:30' }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /available_slots' do
    it 'returns http success' do
      post '/api/v1/bookings/available_slots', params: { duration: '60', date: Time.utc(2022, 11, 1, 10, 30).to_s }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /booking_durations' do
    it 'returns http success' do
      get '/api/v1/bookings/booking_durations'
      expect(response).to have_http_status(:success)
    end
  end
end
