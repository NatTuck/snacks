
import { useState } from 'react';
import { format, startOfDay, addDays } from 'date-fns';
import { DayPicker } from 'react-day-picker';
import { useForm } from 'react-hook-form';
import { useStore } from './store';

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
      <p>Summary</p>
      
      <div className="card mt-4 p-4">
        <h2 className="text-xl font-bold mb-4">Add Snack</h2>
        <form onSubmit={handleSubmit((data) => {
          // Create a new snack with the form data
          const newSnack = {
            id: Date.now(), // Temporary ID
            eaten_on: format(date, 'yyyy-MM-dd'),
            food: {
              name: data.name,
              cals_per_serv: parseInt(data.cals_per_serv),
              serv_size: parseInt(data.serv_size),
              serv_unit: data.serv_unit,
              car_per_serv: parseInt(data.car_per_serv),
              fat_per_serv: parseInt(data.fat_per_serv),
              pro_per_serv: parseInt(data.pro_per_serv),
              fib_per_serv: parseInt(data.fib_per_serv)
            }
          };
          
          addSnack(newSnack);
          reset();
        })}>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div className="form-control">
              <label className="label">
                <span className="label-text">Food Name</span>
              </label>
              <input 
                type="text" 
                className="input input-bordered" 
                {...register("name", { required: "Food name is required" })} 
              />
              {errors.name && <span className="text-error text-sm">{errors.name.message}</span>}
            </div>
            
            <div className="form-control">
              <label className="label">
                <span className="label-text">Calories per Serving</span>
              </label>
              <input 
                type="number" 
                className="input input-bordered" 
                {...register("cals_per_serv", { required: "Calories is required", min: 0 })} 
              />
              {errors.cals_per_serv && <span className="text-error text-sm">{errors.cals_per_serv.message}</span>}
            </div>
            
            <div className="form-control">
              <label className="label">
                <span className="label-text">Serving Size</span>
              </label>
              <input 
                type="number" 
                className="input input-bordered" 
                {...register("serv_size", { required: "Serving size is required", min: 0 })} 
              />
              {errors.serv_size && <span className="text-error text-sm">{errors.serv_size.message}</span>}
            </div>
            
            <div className="form-control">
              <label className="label">
                <span className="label-text">Serving Unit</span>
              </label>
              <input 
                type="text" 
                className="input input-bordered" 
                {...register("serv_unit", { required: "Serving unit is required" })} 
              />
              {errors.serv_unit && <span className="text-error text-sm">{errors.serv_unit.message}</span>}
            </div>
            
            <div className="form-control">
              <label className="label">
                <span className="label-text">Carbs per Serving (g)</span>
              </label>
              <input 
                type="number" 
                className="input input-bordered" 
                {...register("car_per_serv", { required: "Carbs is required", min: 0 })} 
              />
              {errors.car_per_serv && <span className="text-error text-sm">{errors.car_per_serv.message}</span>}
            </div>
            
            <div className="form-control">
              <label className="label">
                <span className="label-text">Fat per Serving (g)</span>
              </label>
              <input 
                type="number" 
                className="input input-bordered" 
                {...register("fat_per_serv", { required: "Fat is required", min: 0 })} 
              />
              {errors.fat_per_serv && <span className="text-error text-sm">{errors.fat_per_serv.message}</span>}
            </div>
            
            <div className="form-control">
              <label className="label">
                <span className="label-text">Protein per Serving (g)</span>
              </label>
              <input 
                type="number" 
                className="input input-bordered" 
                {...register("pro_per_serv", { required: "Protein is required", min: 0 })} 
              />
              {errors.pro_per_serv && <span className="text-error text-sm">{errors.pro_per_serv.message}</span>}
            </div>
            
            <div className="form-control">
              <label className="label">
                <span className="label-text">Fiber per Serving (g)</span>
              </label>
              <input 
                type="number" 
                className="input input-bordered" 
                {...register("fib_per_serv", { required: "Fiber is required", min: 0 })} 
              />
              {errors.fib_per_serv && <span className="text-error text-sm">{errors.fib_per_serv.message}</span>}
            </div>
          </div>
          
          <div className="mt-4">
            <button type="submit" className="btn btn-primary">Add Snack</button>
          </div>
        </form>
      </div>
      
      <p>Snacks List</p>
    </div>
  );
}

export default SnacksPage;
