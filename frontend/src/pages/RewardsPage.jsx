import React, { useState, useEffect } from 'react';
import RewardCard from '../components/RewardCard';
import { useToast } from '../components/Toast';
import { Storage } from '../utils/storage';
import { FaPlay, FaGamepad, FaIceCream, FaCar, FaCoins } from 'react-icons/fa'; // ✅ Tambahkan FaCoins
// Hapus: import { GiCoin } from 'react-icons/gi'; (karena tidak perlu)

const RewardsPage = () => {
  const [totalCoins, setTotalCoins] = useState(0);
  const { showToast } = useToast();

  const rewards = [
    {
      id: 1,
      name: "1 Jam Nonton YouTube Kids",
      coins: 30,
      image: "https://placehold.co/100x100/FFD700/FFFFFF/png?text=📺",
      icon: FaPlay,
    },
    {
      id: 2,
      name: "Main Game 1 Jam",
      coins: 50,
      image: "https://placehold.co/100x100/4CAF50/FFFFFF/png?text=🎮",
      icon: FaGamepad,
    },
    {
      id: 3,
      name: "Makan Es Krim",
      coins: 100,
      image: "https://placehold.co/100x100/FF6B6B/FFFFFF/png?text=🍦",
      icon: FaIceCream,
    },
    {
      id: 4,
      name: "Beli Mainan Baru",
      coins: 200,
      image: "https://placehold.co/100x100/2196F3/FFFFFF/png?text=🧸",
      icon: FaCar,
    },
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
    <div className="bg-yellow-50 min-h-screen p-4">
      {/* Header */}
      <header className="bg-yellow-500 text-white rounded-t-xl shadow-lg p-4 mb-6 flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold">Kids Chore Adventure</h1>
          <div className="flex items-center bg-white bg-opacity-20 rounded-full px-3 py-1 max-w-fit mt-2">
            <FaCoins className="text-2xl text-yellow-200" /> {/* ✅ Gunakan FaCoins */}
            <span className="font-bold text-lg ml-1">{totalCoins}</span>
          </div>
        </div>
      </header>

      {/* Navigation */}
      <nav className="flex bg-white shadow-md rounded-lg overflow-hidden mb-6">
        <button
          onClick={() => (window.location.href = '/')}
          className="flex-1 py-3 px-4 text-center font-bold text-gray-600 hover:bg-gray-50 transition"
        >
          Misi
        </button>
        <button className="flex-1 py-3 px-4 text-center font-bold bg-yellow-500 text-white">
          Hadiah
        </button>
      </nav>

      {/* Rewards Section */}
      <section className="bg-white rounded-lg p-4 shadow-md">
        <h2 className="text-lg font-bold mb-3 flex items-center text-gray-800">
          <svg
            className="w-5 h-5 mr-2 text-red-500"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth="2"
              d="M12 8v13m0-13V6a2 2 0 112 2h-2zm0 0V5.5A2.5 2.5 0 109.5 8H12zm-7 4h14M5 12a2 2 0 110-4h14a2 2 0 110 4M5 12v7a2 2 0 002 2h10a2 2 0 002-2v-7"
            />
          </svg>
          Hadiah
        </h2>

        <div className="grid grid-cols-2 gap-4">
          {rewards.map((reward) => (
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