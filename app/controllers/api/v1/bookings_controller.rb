# frozen_string_literal: true

module Api
  module V1
    class BookingsController < ApplicationController
      include Api::V1::BookingsHelper
      def create
        booking_service = Services::BookingService.new(booking_params)

        if booking_service.create
          render json: booking_service.booking
        else
          render json: { errors: booking_service.booking.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def available_slots
        slots = Services::AvailableSlotsService.new(
          date: available_slots_params[:date],
          duration: available_slots_params[:duration]
        ).list
        render json: slots
      end

      def booking_durations
        render json: super
      end

      private

      def available_slots_params
        params.permit(:date, :duration)
      end

      def booking_params
        params.permit(:date, :duration, :slot)
      end
    end
  end
end
