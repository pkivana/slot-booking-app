import * as React from 'react';
import { useState, useEffect } from "react";
import Calendar from 'react-calendar';
import BookingDuration from '../components/booking_duration';
import Button from '@mui/material/Button';
import Dialog from '@mui/material/Dialog';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';
import DialogTitle from '@mui/material/DialogTitle';
import FlashMessage from 'react-flash-message';
import 'react-calendar/dist/Calendar.css';
import 'bootstrap/dist/css/bootstrap.css';

export default function SlotCalendar() {
    const [date, setDate] = useState(new Date());
    const [error, setError] = useState(null);
    const [duration, setDurationValue] = useState('15');
    const [availableSlots, setAvailableSlots] = useState(null);
    const [slot, setSlot] = useState(null);
    const [showErrorMessage, setShowErrorMessage] = useState(null);
    const [showSuccessMessage, setShowSuccessMessage] = useState(null);
    const [open, setOpen] = React.useState(false);

    let socket = new WebSocket("wss://javascript.info/article/websocket/chat/ws");

    socket.onmessage = function(event) {
        let slot_value = event.data;
        // this will not work for older browsers
        let slot_button = document.querySelector(`button[value="${slot_value}"]`);

        if(slot_button != null) {
            handleAvailableSlots();
            slot_button = null;
        }
    }

    const setDuration = (event) => {
        setDurationValue(event.target.value)
    }

    const options = () => {
        const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");

        const headers = {
            // Add CSRF token required by rails to prevent CSRF Attacks
            'X-CSRF-Token': csrf
        }
        return {
            method: 'POST',
            headers: headers
        };
    }

    const handleBooking = () => {
        fetch(`api/v1/bookings?date=${encodeURIComponent(date)}&duration=${encodeURIComponent(duration)}&slot=${encodeURIComponent(slot)}`, options())
            .then((response) => {
                return response.json();
            })
            .then(() => {
                setOpen(false);
                setShowSuccessMessage(true);
                socket.send(slot);
            })
            .catch((err) => {
                setOpen(false);
                setError(err.message);
                setShowErrorMessage(true);
                console.log(error);
            });
    }

    const handleAvailableSlots = () => {
        fetch(`api/v1/bookings/available_slots?date=${encodeURIComponent(date)}&duration=${encodeURIComponent(duration)}`, options())
            .then((response) => {
                return response.json();
            })
            .then((actualData) => {
                setAvailableSlots(actualData);
                setError(null);
            })
            .catch((err) => {
                setError(err.message);
                setAvailableSlots(null);
                console.log(error);
            });
    }

    const handleClickOpen = (event) => {
        setSlot(event.target.value);
        setOpen(true);
    };

    const handleClose = () => {
        setOpen(false);
    };

    useEffect(() => {
        handleAvailableSlots();
    }, [duration, date]);

    return (
        <>
            <div className="d-flex flex-column min-vh-100 justify-content-center align-items-center">
                <h1>Slot Booking</h1>
                <div className="m-2">
                    <Calendar minDate={new Date()} onChange={setDate} value={date} />
                </div>
                <div className="m-2">
                    <select value={duration} onChange={setDuration} className="form-select" aria-label="Duration select">
                        <BookingDuration />
                    </select>
                </div>
                <div className="booking-slots">
                    <div className="row row-cols-6 justify-content-center">
                        {availableSlots &&
                            availableSlots.map(({ slot }) => (
                                <button onClick={handleClickOpen}
                                        key={slot} value={slot} type="button" className="col btn btn-light">{slot}</button>
                            ))}
                        { showErrorMessage &&
                            <div>
                                <FlashMessage duration={5000}>
                                    <div className="alert alert-danger alert-message" role="alert">
                                        Time slot not booked. Error: {error}
                                    </div>
                                </FlashMessage>
                            </div>
                        }
                        { showSuccessMessage &&
                            <div>
                                <FlashMessage duration={5000}>
                                    <div className="alert alert-success alert-message" role="alert">
                                        Time slot successfully booked.
                                    </div>
                                </FlashMessage>
                            </div>
                        }
                    </div>
                </div>
                <div>
                    <Dialog
                        open={open}
                        onClose={handleClose}
                        aria-labelledby="alert-dialog-title"
                        aria-describedby="alert-dialog-description"
                    >
                        <DialogTitle id="alert-dialog-title">
                            {"Slot booking"}
                        </DialogTitle>
                        <DialogContent>
                            <DialogContentText id="alert-dialog-description">
                                Are you sure you want to book this time slot on {date.toDateString()} at {slot}?
                            </DialogContentText>
                        </DialogContent>
                        <DialogActions>
                            <Button onClick={handleClose}>Cancel</Button>
                            <Button onClick={handleBooking} autoFocus>
                                Book
                            </Button>
                        </DialogActions>
                    </Dialog>
                </div>
            </div>
        </>
    );
}