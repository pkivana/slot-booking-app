# frozen_string_literal: true

class Booking < ApplicationRecord
  validates :start, presence: true
  validates :end, presence: true
  validate :start_is_greater_than_end
  validate :date_is_in_future
  validate :date_does_not_overlap

  private

  def date_is_in_future
    errors.add(:start, message: 'must be in the future') unless start.try(:future?)
    errors.add(:end, message: 'must be in the future') unless self.end.try(:future?)
  end

  # used unix epoch timestamp to check if time overlaps because overlaps? works only for date
  # to_i converts time to an integer number of seconds since the Unix epoch
  def date_does_not_overlap
    return unless self.end && start

    Booking.where('start >= ? AND end <= ?', (start - 1.day), (self.end + 1.day).end_of_day).find_each do |booking|
      errors.add(:start, message: 'overlaps with an existing booking') if booking_overlaps?(booking)
    end
  end

  def start_is_greater_than_end
    return unless self.end && start

    errors.add(:end, message: 'must be greater than start') if self.end <= start
  end

  def booking_overlaps?(booking)
    (start.to_i...self.end.to_i).overlaps?(booking.start.to_i...booking.end.to_i)
  end
end
