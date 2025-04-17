import { useState } from 'react';
import appLogo from './assets/pizza.svg';
import PWABadge from './PWABadge.jsx';

function App() {
  return (
    <div className="flex justify-center w-screen">
      <div className="card shadow-sm lg:w-3/4">
        <div className="flex place-items-center">
          <div>
            <img className="w-20 h-20" src={appLogo} />
          </div>
          <div>
            <h1 className="text-4xl">Snacks</h1>
          </div>
        </div>
        <div className="card">
          <p>Hello</p>
        </div>
        <PWABadge />
      </div>
    </div>
  )
}

export default App;
