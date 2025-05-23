
import { useState } from 'react';
import { format, startOfDay, addDays } from 'date-fns';
import { DayPicker } from 'react-day-picker';
import { useForm } from 'react-hook-form';
import { useStore } from './store';

// FormInput component for consistent form field styling
function FormInput({ label, error, children }) {
  return (
    <div className="form-control w-full">
      <label className="label">
        <span className="label-text">{label}</span>
      </label>
      {children}
      {error && <span className="text-error text-sm mt-1">{error}</span>}
    </div>
  );
}

// Component for displaying stats
function StatsDisplay({ date }) {
  const snacks = useStore((state) => state.snacks);
  
  const filteredSnacks = snacks.filter(snack => 
    snack.eaten_on === format(date, 'yyyy-MM-dd')
  );
  
  const totals = filteredSnacks.reduce((acc, snack) => {
    acc.calories += snack.food.cals_per_serv;
    acc.carbs += snack.food.car_per_serv;
    acc.fat += snack.food.fat_per_serv;
    acc.protein += snack.food.pro_per_serv;
    acc.fiber += snack.food.fib_per_serv;
    return acc;
  }, { calories: 0, carbs: 0, fat: 0, protein: 0, fiber: 0 });
  
  return (
    <>
      <div className="stat">
        <div className="stat-title">Total Calories</div>
        <div className="stat-value">{totals.calories}</div>
        <div className="stat-desc">For {format(date, 'MMM d, yyyy')}</div>
      </div>
      
      <div className="stat">
        <div className="stat-title">Carbs</div>
        <div className="stat-value">{totals.carbs}g</div>
      </div>
      
      <div className="stat">
        <div className="stat-title">Fat</div>
        <div className="stat-value">{totals.fat}g</div>
      </div>
      
      <div className="stat">
        <div className="stat-title">Protein</div>
        <div className="stat-value">{totals.protein}g</div>
      </div>
      
      <div className="stat">
        <div className="stat-title">Fiber</div>
        <div className="stat-value">{totals.fiber}g</div>
      </div>
    </>
  );
}

// Component for displaying snacks table
function SnacksTable({ date }) {
  const snacks = useStore((state) => state.snacks);
  const removeSnack = useStore((state) => state.removeSnack);
  
  console.log("All snacks in store:", snacks);
  console.log("Current date for filtering:", format(date, 'yyyy-MM-dd'));
  
  const filteredSnacks = snacks.filter(snack => {
    console.log("Comparing snack date:", snack.eaten_on, "with current date:", format(date, 'yyyy-MM-dd'));
    // Convert both to simple strings for comparison
    const snackDateStr = snack.eaten_on;
    const currentDateStr = format(date, 'yyyy-MM-dd');
    console.log("String comparison:", snackDateStr, "===", currentDateStr, snackDateStr === currentDateStr);
    return snackDateStr === currentDateStr;
  });
  
  console.log("Filtered snacks:", filteredSnacks);
  
  return (
    <table className="table table-zebra">
      <thead>
        <tr>
          <th>Food Name</th>
          <th>Calories</th>
          <th>Serving Size</th>
          <th>Carbs</th>
          <th>Fat</th>
          <th>Protein</th>
          <th>Fiber</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        {filteredSnacks.length > 0 ? (
          filteredSnacks.map(snack => (
            <tr key={snack.id}>
              <td>{snack.food.name}</td>
              <td>{snack.food.cals_per_serv}</td>
              <td>{snack.food.serv_size} {snack.food.serv_unit}</td>
              <td>{snack.food.car_per_serv}g</td>
              <td>{snack.food.fat_per_serv}g</td>
              <td>{snack.food.pro_per_serv}g</td>
              <td>{snack.food.fib_per_serv}g</td>
              <td>
                <button 
                  className="btn btn-sm btn-error"
                  onClick={() => removeSnack(snack.id)}
                >
                  Delete
                </button>
              </td>
            </tr>
          ))
        ) : (
          <tr>
            <td colSpan="8" className="text-center">No snacks for this day</td>
          </tr>
        )}
      </tbody>
    </table>
  );
}

function SnacksPage() {
  const [date, setDate] = useState(startOfDay(Date()));
  const { register, handleSubmit, reset, formState: { errors } } = useForm();
  const addSnack = useStore((state) => state.addSnack);

  return (
    <div>
      <div className="flex">
        <span className="m-2">
          {format(date, "EEEE, yyyy-MM-dd")}
        </span>
        <button className="btn" onClick={() => setDate(addDays(date, -1))}>
          Previous Day
        </button>
        <button className="btn" onClick={() => setDate(addDays(date, 1))}>
          Next Day
        </button>
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
      <div className="stats shadow mt-4 w-full">
        <StatsDisplay date={date} />
      </div>
      
      <div className="card mt-4 p-4">
        <h2 className="text-xl font-bold mb-4">Add Snack</h2>
        <form onSubmit={handleSubmit((data) => {
          // Create a new snack with the form data
          const newSnack = {
            id: Date.now(), // Temporary ID
            eaten_on: format(date, 'yyyy-MM-dd'),
            food: {
              name: data.name,
              cals_per_serv: parseInt(data.cals_per_serv) || 0,
              serv_size: parseInt(data.serv_size) || 0,
              serv_unit: data.serv_unit || '',
              car_per_serv: parseInt(data.car_per_serv) || 0,
              fat_per_serv: parseInt(data.fat_per_serv) || 0,
              pro_per_serv: parseInt(data.pro_per_serv) || 0,
              fib_per_serv: parseInt(data.fib_per_serv) || 0
            }
          };
          
          console.log("Adding new snack:", newSnack);
          addSnack(newSnack);
          reset();
        })}>
          <div className="grid grid-cols-1 gap-4">
            <FormInput label="Food Name" error={errors.name?.message}>
              <input 
                type="text" 
                className="input input-bordered w-full" 
                {...register("name", { required: "Food name is required" })} 
              />
            </FormInput>
            
            <FormInput label="Calories per Serving" error={errors.cals_per_serv?.message}>
              <input 
                type="number" 
                className="input input-bordered w-full" 
                {...register("cals_per_serv", { required: "Calories is required", min: 0 })} 
              />
            </FormInput>
            
            <div className="grid grid-cols-2 gap-4">
              <FormInput label="Serving Size" error={errors.serv_size?.message}>
                <input 
                  type="number" 
                  className="input input-bordered w-full" 
                  {...register("serv_size", { required: "Serving size is required", min: 0 })} 
                />
              </FormInput>
              
              <FormInput label="Serving Unit" error={errors.serv_unit?.message}>
                <input 
                  type="text" 
                  className="input input-bordered w-full" 
                  {...register("serv_unit", { required: "Serving unit is required" })} 
                />
              </FormInput>
            </div>
            
            <div className="grid grid-cols-2 gap-4">
              <FormInput label="Carbs per Serving (g)" error={errors.car_per_serv?.message}>
                <input 
                  type="number" 
                  className="input input-bordered w-full" 
                  {...register("car_per_serv", { required: "Carbs is required", min: 0 })} 
                />
              </FormInput>
              
              <FormInput label="Fat per Serving (g)" error={errors.fat_per_serv?.message}>
                <input 
                  type="number" 
                  className="input input-bordered w-full" 
                  {...register("fat_per_serv", { required: "Fat is required", min: 0 })} 
                />
              </FormInput>
            </div>
            
            <div className="grid grid-cols-2 gap-4">
              <FormInput label="Protein per Serving (g)" error={errors.pro_per_serv?.message}>
                <input 
                  type="number" 
                  className="input input-bordered w-full" 
                  {...register("pro_per_serv", { required: "Protein is required", min: 0 })} 
                />
              </FormInput>
              
              <FormInput label="Fiber per Serving (g)" error={errors.fib_per_serv?.message}>
                <input 
                  type="number" 
                  className="input input-bordered w-full" 
                  {...register("fib_per_serv", { required: "Fiber is required", min: 0 })} 
                />
              </FormInput>
            </div>
          </div>
          
          <div className="mt-4">
            <button type="submit" className="btn btn-primary">Add Snack</button>
          </div>
        </form>
      </div>
      
      <div className="overflow-x-auto mt-4">
        <SnacksTable date={date} />
      </div>
    </div>
  );
}

export default SnacksPage;
