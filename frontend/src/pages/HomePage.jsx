import React, { useState, useEffect } from 'react';
import MissionCard from '../components/MissionCard';
import ParentVerificationModal from '../components/ParentVerificationModal';
import { useToast } from '../components/Toast';
import { Storage } from '../utils/storage';
import { formatDate } from '../utils/date';
import { FaStar, FaCoins } from 'react-icons/fa'; // ✅ Ganti: FaCoins gantikan GiCoin

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
    const updatedMissions = missions.map((m) =>
      m.id === mission.id ? { ...m, completed: true } : m
    );
    setMissions(updatedMissions);
    Storage.saveMissions(updatedMissions);

    setCurrentMission(mission);
    setShowVerification(true);
  };

  const handleVerify = () => {
    if (currentMission) {
      const mission = missions.find((m) => m.id === currentMission.id);
      if (mission && !mission.verified) {
        const newTotal = totalCoins + mission.coins;
        setTotalCoins(newTotal);
        Storage.saveTotalCoins(newTotal);

        const updatedMissions = missions.map((m) =>
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
    <div className="bg-yellow-50 min-h-screen p-4">
      {/* Header */}
      <header className="bg-yellow-500 text-white rounded-t-xl shadow-lg p-4 mb-6 flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold">Bantu Ayah Ibu</h1>
          <p className="text-sm opacity-70">{formatDate()}</p>
        </div>
        <div className="flex items-center bg-white bg-opacity-20 rounded-full px-3 py-1 max-w-fit">
          <FaCoins className="text-2xl text-yellow-200" /> {/* ✅ Ikon koin yang benar, tampilan tetap mirip */}
          <span className="font-bold text-lg ml-1">{totalCoins}</span>
        </div>
      </header>

      {/* Navigation */}
      <nav className="flex bg-white shadow-md rounded-lg overflow-hidden mb-6">
        <button
          className="flex-1 py-3 px-4 text-center font-bold bg-yellow-500 text-white"
        >
          Misi
        </button>
        <button
          onClick={() => (window.location.href = '/rewards')}
          className="flex-1 py-3 px-4 text-center font-bold text-gray-600 hover:bg-gray-50 transition"
        >
          Hadiah
        </button>
      </nav>

      {/* Daily Missions Section */}
      <section className="bg-white rounded-lg p-4 shadow-md">
        <h2 className="text-lg font-bold mb-3 flex items-center text-gray-800">
          <svg
            className="w-5 h-5 mr-2 text-green-500"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth="2"
              d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 012-2h2a2 2 0 012 2M9 5a2 2 0 002 2h2a2 2 0 002-2"
            />
          </svg>
          Misi Harian
        </h2>

        <div className="space-y-3">
          {missions.map((mission) => (
            <MissionCard
              key={mission.id}
              mission={mission}
              onVerify={handleCompleteMission}
            />
          ))}
        </div>
      </section>

      {/* Verification Modal */}
      <ParentVerificationModal
        show={showVerification}
        onClose={handleCloseModal}
        mission={currentMission}
        onVerify={handleVerify}
      />

      {/* Toast Container */}
      <ToastContainer />
    </div>
  );
};

export default HomePage;