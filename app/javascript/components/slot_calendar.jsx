import * as React from 'react';
import { useState } from 'react';
import Calendar from 'react-calendar';
import 'react-calendar/dist/Calendar.css';
import 'bootstrap/dist/css/bootstrap.css';

export default function SlotCalendar() {
    const [date, setDate] = useState(new Date());

    return (
        <>
            <div className="d-flex flex-column min-vh-100 justify-content-center align-items-center">
                <h1>Slot Booking</h1>
                <div>
                    <Calendar minDate={new Date()} onChange={setDate} value={date} />
                </div>
            </div>
        </>
    );
}