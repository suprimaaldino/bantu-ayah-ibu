# PowerShell Script untuk membuat struktur folder Kids Chore Adventure
# Simpan sebagai create-kids-chore-app.ps1 dan jalankan dengan PowerShell

Write-Host "Membuat struktur folder Kids Chore Adventure..." -ForegroundColor Green

# 1. Buat folder utama dan subfolder
$root = "daily-mission-app"
$folders = @(
    "$root/backend/controllers",
    "$root/backend/models",
    "$root/backend/routes",
    "$root/backend/middlewares",
    "$root/backend/utils",
    "$root/backend/config",
    "$root/frontend/public",
    "$root/frontend/src/assets/icons",
    "$root/frontend/src/assets/images",
    "$root/frontend/src/components",
    "$root/frontend/src/pages",
    "$root/frontend/src/utils",
    "$root/database",
    "$root/docs/UI_wireframes"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Path $folder -Force | Out-Null
}

Write-Host "Struktur folder berhasil dibuat!" -ForegroundColor Green

# 2. Buat file-file dengan konten

# File: frontend/public/index.html
$indexHtml = @'
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kids Chore Adventure</title>
</head>
<body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
</body>
</html>
'@
Set-Content -Path "$root/frontend/public/index.html" -Value $indexHtml

# File: frontend/src/main.jsx
$mainJsx = @'
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.css';

const container = document.getElementById('root');
const root = ReactDOM.createRoot(container);
root.render(<App />);
'@
Set-Content -Path "$root/frontend/src/main.jsx" -Value $mainJsx

# File: frontend/src/index.css
$indexCss = @'
@tailwind base;
@tailwind components;
@tailwind utilities;

@keyframes float {
    0% { transform: translateY(0px); }
    50% { transform: translateY(-10px); }
    100% { transform: translateY(0px); }
}

.float {
    animation: float 3s ease-in-out infinite;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

.coin {
    animation: spin 2s linear infinite;
}

.toast {
    position: fixed;
    bottom: 20px;
    left: 50%;
    transform: translateX(-50%);
    background: rgba(0,0,0,0.8);
    color: white;
    padding: 12px 24px;
    border-radius: 50px;
    z-index: 1000;
    opacity: 0;
    transition: opacity 0.3s;
}

.toast.show {
    opacity: 1;
}

.hold-active {
    background-color: #fef3c7 !important;
    border-color: #f59e0b !important;
}

.hold-active p {
    color: #92400e !important;
}
'@
Set-Content -Path "$root/frontend/src/index.css" -Value $indexCss

# File: frontend/src/App.jsx
$appJsx = @'
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
'@
Set-Content -Path "$root/frontend/src/App.jsx" -Value $appJsx

# File: frontend/src/utils/storage.js
$storageJs = @'
export const Storage = {
  getMissions: () => {
    const missions = localStorage.getItem('missions');
    return missions ? JSON.parse(missions) : [
      { id: 1, name: "Merapikan tempat tidur", coins: 5, completed: false, verified: false },
      { id: 2, name: "Mencuci piring", coins: 10, completed: false, verified: false },
      { id: 3, name: "Menyiram tanaman", coins: 7, completed: false, verified: false },
      { id: 4, name: "Membantu masak", coins: 12, completed: false, verified: false },
      { id: 5, name: "Membersihkan kamar", coins: 15, completed: false, verified: false },
      { id: 6, name: "Menyapu lantai", coins: 8, completed: false, verified: false },
      { id: 7, name: "Menjemur pakaian", coins: 6, completed: false, verified: false },
      { id: 8, name: "Mengelap meja", coins: 4, completed: false, verified: false },
      { id: 9, name: "Memberi makan hewan peliharaan", coins: 9, completed: false, verified: false },
      { id: 10, name: "Mengambil sampah", coins: 5, completed: false, verified: false }
    ];
  },

  saveMissions: (missions) => {
    localStorage.setItem('missions', JSON.stringify(missions));
  },

  getTotalCoins: () => {
    const coins = localStorage.getItem('totalCoins');
    return coins ? parseInt(coins) : 0;
  },

  saveTotalCoins: (coins) => {
    localStorage.setItem('totalCoins', coins.toString());
  },

  getLastResetDate: () => {
    return localStorage.getItem('lastResetDate');
  },

  saveLastResetDate: (date) => {
    localStorage.setItem('lastResetDate', date);
  },

  resetDailyMissions: () => {
    const today = new Date().toISOString().split('T')[0];
    const lastReset = this.getLastResetDate();
    
    if (!lastReset || lastReset !== today) {
      const defaultMissions = this.getMissions().map(m => ({
        ...m,
        completed: false,
        verified: false
      }));
      
      this.saveMissions(defaultMissions);
      this.saveLastResetDate(today);
      return { missions: defaultMissions, reset: true };
    }
    
    return { missions: this.getMissions(), reset: false };
  }
};
'@
Set-Content -Path "$root/frontend/src/utils/storage.js" -Value $storageJs

# File: frontend/src/utils/date.js
$dateJs = @'
export const formatDate = () => {
  const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
  return new Date().toLocaleDateString('id-ID', options);
};

export const isToday = (dateString) => {
  const today = new Date().toISOString().split('T')[0];
  return dateString === today;
};
'@
Set-Content -Path "$root/frontend/src/utils/date.js" -Value $dateJs

# File: frontend/src/components/MissionCard.jsx
$missionCardJsx = @'
import React from 'react';

const MissionCard = ({ mission, onVerify }) => {
  return (
    <div className={`bg-white rounded-xl p-4 shadow-md border-l-4 transition-all ${
      mission.verified ? 'border-green-500' : 
      mission.completed ? 'border-yellow-300' : 'border-yellow-500'
    }`}>
      <div className="flex justify-between items-start">
        <div>
          <h3 className="font-bold text-lg text-gray-800">{mission.name}</h3>
          <p className="text-green-500 font-bold mt-1">+{mission.coins} koin</p>
        </div>
        <div className="text-right">
          {mission.verified ? (
            <span className="bg-green-100 text-green-800 text-xs px-2 py-1 rounded-full font-bold">
              Selesai ✓
            </span>
          ) : mission.completed ? (
            <button
              onClick={() => onVerify(mission)}
              className="bg-yellow-100 hover:bg-yellow-200 text-yellow-800 font-bold py-1 px-3 rounded mt-1 text-sm transition"
            >
              Minta Verifikasi
            </button>
          ) : (
            <button
              onClick={() => onVerify(mission)}
              className="bg-yellow-500 hover:bg-yellow-400 text-white font-bold py-1 px-3 rounded mt-1 text-sm transition"
            >
              Selesai
            </button>
          )}
        </div>
      </div>
    </div>
  );
};

export default MissionCard;
'@
Set-Content -Path "$root/frontend/src/components/MissionCard.jsx" -Value $missionCardJsx

# File: frontend/src/components/RewardCard.jsx
$rewardCardJsx = @'
import React from 'react';

const RewardCard = ({ reward, totalCoins, onRedeem }) => {
  const canRedeem = totalCoins >= reward.coins;

  return (
    <div className="bg-white rounded-xl overflow-hidden shadow-md">
      <div className="p-3">
        <img src={reward.image} alt={reward.name} className="w-full h-24 object-contain mb-2" />
        <h3 className="font-bold text-sm text-gray-800">{reward.name}</h3>
        <div className="flex justify-between items-center mt-2">
          <span className="bg-yellow-100 text-yellow-800 text-xs px-2 py-1 rounded-full font-bold">
            {reward.coins} koin
          </span>
          <button
            onClick={() => onRedeem(reward)}
            disabled={!canRedeem}
            className={`bg-gray-200 hover:bg-gray-300 text-gray-800 font-bold py-1 px-2 rounded text-xs transition ${
              !canRedeem ? 'opacity-50 cursor-not-allowed' : 'hover:bg-green-100'
            }`}
          >
            Tukar
          </button>
        </div>
      </div>
    </div>
  );
};

export default RewardCard;
'@
Set-Content -Path "$root/frontend/src/components/RewardCard.jsx" -Value $rewardCardJsx

# File: frontend/src/components/ParentVerificationModal.jsx
$modalJsx = @'
import React, { useState } from 'react';

const ParentVerificationModal = ({ show, onClose, mission, onVerify }) => {
  const [pin, setPin] = useState('');
  const [holdActive, setHoldActive] = useState(false);
  let holdTimer = null;

  const handlePinSubmit = () => {
    if (pin === '1234') {
      onVerify();
    } else {
      alert('PIN salah! Coba lagi');
    }
  };

  const startHold = () => {
    holdTimer = setTimeout(() => {
      setHoldActive(true);
      onVerify();
    }, 3000);
  };

  const endHold = () => {
    if (holdTimer) {
      clearTimeout(holdTimer);
    }
    setHoldActive(false);
  };

  if (!show) return null;

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
      <div className="bg-white rounded-2xl p-6 w-full max-w-md">
        <h3 className="text-2xl font-bold text-center mb-4 text-gray-800">Verifikasi Orang Tua</h3>
        <p className="text-center text-gray-600 mb-6">
          Misi "<span className="font-bold">{mission?.name}</span>" selesai. 
          Harap minta orang tua untuk verifikasi.
        </p>
        
        <div className="mb-6">
          <button
            onClick={() => document.getElementById('pin-container').classList.toggle('hidden')}
            className="w-full bg-blue-100 hover:bg-blue-200 text-blue-800 font-bold py-3 px-4 rounded-lg mb-3 transition"
          >
            Masukkan PIN
          </button>
          
          <div id="pin-container" className="hidden">
            <input
              type="password"
              value={pin}
              onChange={(e) => setPin(e.target.value)}
              maxLength="4"
              className="w-full text-center text-2xl py-2 px-4 border-2 border-gray-300 rounded-lg mb-3 font-bold"
              placeholder="****"
            />
            <button
              onClick={handlePinSubmit}
              className="w-full bg-green-500 hover:bg-green-600 text-white font-bold py-3 px-4 rounded-lg"
            >
              Verifikasi
            </button>
          </div>
        </div>
        
        <div className="text-center">
          <p className="text-gray-500 text-sm mb-2">Atau tahan tombol selama 3 detik</p>
          <div
            className={`bg-yellow-100 border-2 border-dashed rounded-xl p-4 cursor-pointer transition ${
              holdActive ? 'bg-yellow-200 border-yellow-500' : 'border-yellow-300'
            }`}
            onTouchStart={startHold}
            onTouchEnd={endHold}
            onMouseDown={startHold}
            onMouseUp={endHold}
            onMouseLeave={endHold}
          >
            <p className={`font-medium ${holdActive ? 'text-yellow-800' : 'text-yellow-700'}`}>
              {holdActive ? '✓ Terverifikasi!' : 'Tahan untuk Verifikasi'}
            </p>
          </div>
        </div>
        
        <button
          onClick={onClose}
          className="mt-6 w-full bg-gray-100 hover:bg-gray-200 text-gray-700 font-bold py-2 px-4 rounded-lg transition"
        >
          Batal
        </button>
      </div>
    </div>
  );
};

export default ParentVerificationModal;
'@
Set-Content -Path "$root/frontend/src/components/ParentVerificationModal.jsx" -Value $modalJsx

# File: frontend/src/components/Toast.jsx
$toastJsx = @'
import React, { useState, useEffect } from 'react';

export const ToastContainer = () => {
  const [toasts, setToasts] = useState([]);

  const addToast = (message, type = 'success') => {
    const id = Date.now();
    setToasts(prev => [...prev, { id, message, type }]);
  };

  const removeToast = (id) => {
    setToasts(prev => prev.filter(t => t.id !== id));
  };

  useEffect(() => {
    const timers = toasts.map(toast => {
      const timer = setTimeout(() => {
        removeToast(toast.id);
      }, 3000);
      return timer;
    });

    return () => {
      timers.forEach(timer => clearTimeout(timer));
    };
  }, [toasts]);

  return (
    <div className="fixed bottom-4 left-1/2 transform -translate-x-1/2 z-50">
      {toasts.map(toast => (
        <div
          key={toast.id}
          className={`mb-2 px-4 py-2 rounded-full text-white text-sm shadow-lg transition-opacity duration-300 ${
            toast.type === 'success' ? 'bg-green-500' : 'bg-red-500'
          }`}
        >
          {toast.message}
        </div>
      ))}
    </div>
  );
};

export const useToast = () => {
  const [toasts, setToasts] = useState([]);

  const showToast = (message, type = 'success') => {
    const id = Date.now();
    setToasts(prev => [...prev, { id, message, type }]);
    setTimeout(() => {
      setToasts(prev => prev.filter(t => t.id !== id));
    }, 3000);
  };

  return { showToast, ToastContainer };
};
'@
Set-Content -Path "$root/frontend/src/components/Toast.jsx" -Value $toastJsx

# File: frontend/src/pages/HomePage.jsx
$homePageJsx = @'
import React, { useState, useEffect } from 'react';
import MissionCard from '../components/MissionCard';
import ParentVerificationModal from '../components/ParentVerificationModal';
import { useToast } from '../components/Toast';
import { Storage } from '../utils/storage';
import { formatDate } from '../utils/date';

const HomePage = () => {
  const [missions, setMissions] = useState([]);
  const [totalCoins, setTotalCoins] = useState(0);
  const [showVerification, setShowVerification] = useState(false);
  const [currentMission, setCurrentMission] = useState(null);
  const { showToast, ToastContainer } = useToast();

  useEffect(() => {
    const { missions: storedMissions, reset } = Storage.resetDailyMissions();
    setMissions(storedMissions);
    
    const coins = Storage.getTotalCoins();
    setTotalCoins(coins);
    
    if (reset) {
      showToast("Misi harian telah direset!");
    }
  }, []);

  const handleCompleteMission = (mission) => {
    setCurrentMission(mission);
    setShowVerification(true);
  };

  const handleVerify = () => {
    if (currentMission) {
      const mission = missions.find(m => m.id === currentMission.id);
      if (mission && !mission.verified) {
        const newTotal = totalCoins + mission.coins;
        setTotalCoins(newTotal);
        Storage.saveTotalCoins(newTotal);
        
        const updatedMissions = missions.map(m => 
          m.id === mission.id ? { ...m, verified: true } : m
        );
        setMissions(updatedMissions);
        Storage.saveMissions(updatedMissions);
        
        setShowVerification(false);
        setCurrentMission(null);
        showToast(`Misi selesai! +${mission.coins} koin`);
      }
    }
  };

  const handleCloseModal = () => {
    setShowVerification(false);
    setCurrentMission(null);
  };

  return (
    <div className="p-4">
      <header className="bg-yellow-500 text-white p-4 rounded-t-lg shadow-md mb-4">
        <h1 className="text-xl font-bold">Kids Chore Adventure</h1>
        <p className="text-sm opacity-90">{formatDate()}</p>
        <div className="flex items-center justify-between mt-2">
          <span className="text-xl mr-2">🪙</span>
          <span className="font-bold text-lg">{totalCoins}</span>
        </div>
      </header>

      <nav className="flex bg-white shadow-md mb-6">
        <button className="flex-1 py-3 px-4 text-center font-bold bg-yellow-500 text-white">
          Misi
        </button>
        <button 
          onClick={() => window.location.href = '/rewards'}
          className="flex-1 py-3 px-4 text-center font-bold text-gray-600"
        >
          Hadiah
        </button>
      </nav>

      <section>
        <h2 className="text-xl font-bold mb-4 flex items-center">
          <svg className="w-6 h-6 mr-2 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
          </svg>
          Misi Harian
        </h2>
        
        <div className="space-y-3">
          {missions.map(mission => (
            <MissionCard
              key={mission.id}
              mission={mission}
              onVerify={handleCompleteMission}
            />
          ))}
        </div>
      </section>

      <ParentVerificationModal
        show={showVerification}
        onClose={handleCloseModal}
        mission={currentMission}
        onVerify={handleVerify}
      />
      
      <ToastContainer />
    </div>
  );
};

export default HomePage;
'@
Set-Content -Path "$root/frontend/src/pages/HomePage.jsx" -Value $homePageJsx

# File: frontend/src/pages/RewardsPage.jsx
$rewardsPageJsx = @'
import React, { useState, useEffect } from 'react';
import RewardCard from '../components/RewardCard';
import { useToast } from '../components/Toast';
import { Storage } from '../utils/storage';

const RewardsPage = () => {
  const [totalCoins, setTotalCoins] = useState(0);
  const { showToast } = useToast();

  const rewards = [
    { id: 1, name: "1 Jam Nonton YouTube Kids", coins: 30, image: "https://placehold.co/100x100/FFD700/FFFFFF/png?text=📺" },
    { id: 2, name: "Main Game 1 Jam", coins: 50, image: "https://placehold.co/100x100/4CAF50/FFFFFF/png?text=🎮" },
    { id: 3, name: "Makan Es Krim", coins: 100, image: "https://placehold.co/100x100/FF6B6B/FFFFFF/png?text=🍦" },
    { id: 4, name: "Beli Mainan Baru", coins: 200, image: "https://placehold.co/100x100/2196F3/FFFFFF/png?text=🧸" }
  ];

  useEffect(() => {
    const coins = Storage.getTotalCoins();
    setTotalCoins(coins);
  }, []);

  const handleRedeemReward = (reward) => {
    if (totalCoins >= reward.coins) {
      const newTotal = totalCoins - reward.coins;
      setTotalCoins(newTotal);
      Storage.saveTotalCoins(newTotal);
      showToast(`Selamat! Kamu mendapatkan ${reward.name}`);
    } else {
      showToast('Koin tidak cukup!', 'error');
    }
  };

  return (
    <div className="p-4">
      <header className="bg-yellow-500 text-white p-4 rounded-t-lg shadow-md mb-4">
        <h1 className="text-xl font-bold">Kids Chore Adventure</h1>
        <div className="flex items-center justify-between mt-2">
          <span className="text-xl mr-2">🪙</span>
          <span className="font-bold text-lg">{totalCoins}</span>
        </div>
      </header>

      <nav className="flex bg-white shadow-md mb-6">
        <button 
          onClick={() => window.location.href = '/'}
          className="flex-1 py-3 px-4 text-center font-bold text-gray-600"
        >
          Misi
        </button>
        <button className="flex-1 py-3 px-4 text-center font-bold bg-yellow-500 text-white">
          Hadiah
        </button>
      </nav>

      <section>
        <h2 className="text-xl font-bold mb-4 flex items-center">
          <svg className="w-6 h-6 mr-2 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 8v13m0-13V6a2 2 0 112 2h-2zm0 0V5.5A2.5 2.5 0 109.5 8H12zm-7 4h14M5 12a2 2 0 110-4h14a2 2 0 110 4M5 12v7a2 2 0 002 2h10a2 2 0 002-2v-7" />
          </svg>
          Hadiah
        </h2>
        
        <div className="grid grid-cols-2 gap-3">
          {rewards.map(reward => (
            <RewardCard
              key={reward.id}
              reward={reward}
              totalCoins={totalCoins}
              onRedeem={handleRedeemReward}
            />
          ))}
        </div>
      </section>
    </div>
  );
};

export default RewardsPage;
'@
Set-Content -Path "$root/frontend/src/pages/RewardsPage.jsx" -Value $rewardsPageJsx

# File: frontend/src/pages/ParentDashboard.jsx
$dashboardJsx = @'
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
'@
Set-Content -Path "$root/frontend/src/pages/ParentDashboard.jsx" -Value $dashboardJsx

# File: frontend/package.json
$packageJson = @'
{
  "name": "kids-chore-adventure",
  "private": true,
  "version": "0.1.0",
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.8.0"
  },
  "devDependencies": {
    "@vitejs/plugin-react": "^3.1.0",
    "vite": "^4.1.0",
    "tailwindcss": "^3.2.4"
  },
  "scripts": {
    "start": "vite",
    "build": "vite build",
    "preview": "vite preview"
  }
}
'@
Set-Content -Path "$root/frontend/package.json" -Value $packageJson

# File: root package.json
$rootPackageJson = @'
{
  "name": "daily-mission-app",
  "version": "1.0.0",
  "description": "Game misi harian untuk anak-anak",
  "scripts": {
    "frontend": "cd frontend && npm start",
    "backend": "cd backend && npm start"
  }
}
'@
Set-Content -Path "$root/package.json" -Value $rootPackageJson

# File: database/seed.json
$seedJson = @'
{
  "missions": [
    { "id": 1, "name": "Merapikan tempat tidur", "coins": 5 },
    { "id": 2, "name": "Mencuci piring", "coins": 10 },
    { "id": 3, "name": "Menyiram tanaman", "coins": 7 },
    { "id": 4, "name": "Membantu masak", "coins": 12 },
    { "id": 5, "name": "Membersihkan kamar", "coins": 15 },
    { "id": 6, "name": "Menyapu lantai", "coins": 8 },
    { "id": 7, "name": "Menjemur pakaian", "coins": 6 },
    { "id": 8, "name": "Mengelap meja", "coins": 4 },
    { "id": 9, "name": "Memberi makan hewan peliharaan", "coins": 9 },
    { "id": 10, "name": "Mengambil sampah", "coins": 5 }
  ],
  "rewards": [
    { "id": 1, "name": "1 Jam Nonton YouTube Kids", "coins": 30 },
    { "id": 2, "name": "Main Game 1 Jam", "coins": 50 },
    { "id": 3, "name": "Makan Es Krim", "coins": 100 },
    { "id": 4, "name": "Beli Mainan Baru", "coins": 200 }
  ]
}
'@
Set-Content -Path "$root/database/seed.json" -Value $seedJson

# File: docs/README.md
$docsReadme = "## Kids Chore Adventure`n`nGame edukatif untuk membantu anak-anak belajar tanggung jawab dengan menyelesaikan misi harian.`n`n### Fitur Utama`n- 10 misi harian`n- Sistem koin`n- Verifikasi orang tua`n- Reset harian`n- UI ramah anak"
Set-Content -Path "$root/docs/README.md" -Value $docsReadme

Write-Host "Semua file telah berhasil dibuat!" -ForegroundColor Green
Write-Host "Langkah berikutnya:" -ForegroundColor Yellow
Write-Host "1. Buka folder daily-mission-app/frontend" -ForegroundColor Yellow
Write-Host "2. Jalankan: npm install" -ForegroundColor Yellow
Write-Host "3. Jalankan: npm start" -ForegroundColor Yellow