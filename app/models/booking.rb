# frozen_string_literal: true

class Booking < ApplicationRecord
  validates :start, presence: true
  validates :end, presence: true
end
