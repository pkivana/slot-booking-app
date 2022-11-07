import React, { useState, useEffect } from 'react';

export default function BookingDuration() {
    const [error, setError] = useState(null);
    const [bookingDurations, setBookingDurations] = useState(null);

    useEffect(() => {
        fetch(`api/v1/bookings/booking_durations`)
            .then((response) => {
                return response.json();
            })
            .then((actualData) => {
                setBookingDurations(actualData);
                setError(null);
            })
            .catch((err) => {
                setError(err.message);
                setBookingDurations(null);
                console.log(error);
            });
    }, []);

    return (
        <>
            {bookingDurations &&
                bookingDurations.map(({ duration, duration_humanized }) => (
                    <option key={duration}  value={duration}>{duration_humanized}</option>
                ))
            }
        </>
    );
}