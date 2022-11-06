import React from 'react';
import ReactDOM from 'react-dom/client';
import SlotCalendar from '../components/slot_calendar'
import '../styles/main.scss'

const container = document.getElementById('main');
const root = ReactDOM.createRoot(container);
root.render(<SlotCalendar name="Slot calendar" />);