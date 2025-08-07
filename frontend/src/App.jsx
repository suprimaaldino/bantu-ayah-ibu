import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import HomePage from './pages/HomePage';
import RewardsPage from './pages/RewardsPage';
import ParentDashboard from './pages/ParentDashboard';
import { ToastContainer } from './components/Toast';



function App() {
  return (
    <Router>
      <div className="bg-yellow-50 min-h-screen font-sans">
        <ToastContainer />
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/rewards" element={<RewardsPage />} />
          <Route path="/parent-dashboard" element={<ParentDashboard />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;


