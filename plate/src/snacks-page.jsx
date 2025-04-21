
import { useState } from 'react';
import { format, startOfDay } from 'date-fns';
import { DayPicker } from 'react-day-picker';

function SnacksPage() {
  const [date, setDate] = useState(startOfDay(Date()));

  return (
    <div>
      <div className="flex">
        <span className="m-2">
          {format(date, "EEEE, yyyy-MM-dd")}
        </span>
        <button className="btn" popoverTarget="day-picker-po">
          Calendar
        </button>
        <div
          popover="auto"
          id="day-picker-po"
          className="dropdown"
          style={{ positionAnchor: "--rdp" }}>
          <DayPicker
            className="react-day-picker"
            mode="single"
            selected={date}
            onSelect={setDate} />
        </div>
      </div>
      <p>Summary</p>
      <p>Add Snack</p>
      <p>Snacks List</p>
    </div>
  );
}

export default SnacksPage;
