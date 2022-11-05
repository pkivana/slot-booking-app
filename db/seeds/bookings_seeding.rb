# frozen_string_literal: true

require 'json'

def seed_bookings
  Rails.logger.debug 'Seeding bookings...'

  file = File.read('db/seeds/data/bookings.json')
  data_hash = JSON.parse(file)

  data_hash.each do |booking|
    Booking.create!(start: booking['start'], end: booking['end'])
  rescue StandardError => e
    Rails.logger.info "Failed to create booking #{e}"
  end
  Rails.logger.debug 'Seeding bookings done.'
end
