# frozen_string_literal: true

class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.timestamp :start, null: false
      t.timestamp :end, null: false

      t.timestamps
    end
  end
end
