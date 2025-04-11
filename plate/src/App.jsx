import { useState } from 'react';
import appLogo from './assets/pizza.svg';
import PWABadge from './PWABadge.jsx';

function App() {
  const [count, setCount] = useState(0);

  return (
    <div className="flex justify-center w-screen">
      <div className="card shadow-sm container">
        <div>
          <img className="w-20 h-20" src={appLogo} />
        </div>
        <h1 className="text-3xl font-bold">plate</h1>
        <div className="hidden md:block">
          <p>At least md</p>
        </div >
        <div className="card">
          <button className="btn btn-neutral w-50" onClick={() => setCount((count) => count + 1)}>
            count is {count}
          </button>
          <p>
            Edit <code>src/App.jsx</code> and save to test HMR
          </p>
        </div>
        <p className="read-the-docs">
          Click on the Vite and React logos to learn more
        </p>
        <PWABadge />
      </div>
    </div>
  )
}

export default App;
