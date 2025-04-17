
import { HashRouter, Routes, Route } from 'react-router';

import appLogo from './assets/pizza.svg';
import PWABadge from './PWABadge.jsx';
import LoginForm from './login-form.jsx';

function App() {
  return (
    <HashRouter>
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
            <Routes>
              <Route index element={<LoginForm />} />
            </Routes>
          </div>
          <PWABadge />
        </div>
      </div>
    </HashRouter>
  )
}

export default App;
