import { useState } from 'react';
import appLogo from '/favicon.svg';
import PWABadge from './PWABadge.jsx';

function App() {
  const [count, setCount] = useState(0)

  return (
    <div className="card shadow-sm">
      <div></div>
      <h1>plate</h1>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
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
  )
}

export default App;
