import React from 'react';
import ReactDOM from 'react-dom/client';

export default function Hello() {
    return (
        <p>Hello there</p>
    )
}

const container = document.getElementById('main');
const root = ReactDOM.createRoot(container);
root.render(<Hello name="React" />,);