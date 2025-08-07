import React from 'react';

const ParentDashboard = () => {
  return (
    <div className="p-4">
      <header className="bg-yellow-500 text-white p-4 rounded-t-lg shadow-md mb-4">
        <h1 className="text-xl font-bold">Parent Dashboard</h1>
      </header>

      <nav className="flex bg-white shadow-md mb-6">
        <button 
          onClick={() => window.location.href = '/'}
          className="flex-1 py-3 px-4 text-center font-bold text-gray-600"
        >
          Misi
        </button>
        <button 
          onClick={() => window.location.href = '/rewards'}
          className="flex-1 py-3 px-4 text-center font-bold text-gray-600"
        >
          Hadiah
        </button>
        <button className="flex-1 py-3 px-4 text-center font-bold bg-yellow-500 text-white">
          Dashboard
        </button>
      </nav>

      <div className="bg-white rounded-xl p-6 shadow-md">
        <h2 className="text-xl font-bold mb-4">Parent Controls</h2>
        <p>Fitur ini memungkinkan orang tua mengelola misi dan hadiah.</p>
        <div className="mt-4 space-y-3">
          <div className="p-3 bg-gray-100 rounded-lg">
            <h3 className="font-bold">PIN Verification: 1234</h3>
          </div>
          <div className="p-3 bg-gray-100 rounded-lg">
            <h3 className="font-bold">Total Coins: {localStorage.getItem('totalCoins') || 0}</h3>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ParentDashboard;
