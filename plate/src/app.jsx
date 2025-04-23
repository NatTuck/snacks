
import { 
  HashRouter, Routes, Route, Navigate, useLocation
} from 'react-router';

import appLogo from './assets/pizza.svg';
import PWABadge from './pwa-badge.jsx';
import LoginPage from './login-page.jsx';
import SnacksPage from './snacks-page.jsx';
import { useStore } from './store';


function App() {

  return (
    <HashRouter>
      <div className="flex justify-center w-screen">
        <div className="card shadow-sm lg:w-3/4">
          <div className="grid grid-cols-6 gap-x-4 items-center">
            <div className="flex col-span-1 items-center">
              <img className="w-20 h-20" src={appLogo} />
              <h1 className="text-4xl">Snacks</h1>
            </div>
            <div className="col-span-5 text-right">
              <SessionInfo />
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

function SessionInfo() {
  let session = useStore((state) => state.session);
  let logout = useStore((state) => state.logout);
  let location = useLocation();
  let path = location.pathname;

  if (session) {
    return (
      <div>
        <p>
          Hi, {session.email} | &nbsp;
          <button className="btn btn-small" onClick={logout}>
            Log Out
          </button>
        </p>
      </div>
    );
  }
  else {
    if (path != "/" && path != "/register") {
      return <Navigate to="/" />
    }
    else {
      return null;
    }
  }
}

export default App;
