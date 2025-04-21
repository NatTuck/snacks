
import { HashRouter, Routes, Route } from 'react-router';

import appLogo from './assets/pizza.svg';
import PWABadge from './pwa-badge.jsx';
import LoginPage from './login-page.jsx';
import SnacksPage from './snacks-page.jsx';

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
              <Route path="/" exact element={<LoginPage />} />
              <Route path="/snacks" element={<SnacksPage />} />
            </Routes>
          </div>
          <PWABadge />
        </div>
      </div>
    </HashRouter>
  );
}

export default App;
