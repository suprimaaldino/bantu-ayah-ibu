import React from 'react';

// ✅ Gunakan ikon yang benar-benar tersedia
import {
  GiBed,
  GiWaterFlask,          
  GiWateringCan,
  GiBroom,
  GiRecycle,
  GiWaterSplash,
  GiClothes,
  GiShoppingCart,
  GiBookshelf,
  GiToyMallet,
} from 'react-icons/gi';

const MissionCard = ({ mission, onVerify }) => {
  const iconMap = {
    'Marapikan tempat tidur': GiBed,
    'Mencuci piring': GiWaterFlask,               // ✅ Sudah diperbaiki
    'Menyiram tanaman': GiWateringCan,
    'Membersihkan ruangan': GiBroom,
    'Buang sampah': GiRecycle,
    'Mandi dan sikat gigi': GiWaterSplash,
    'Lipat baju': GiClothes,
    'Beli kebutuhan rumah': GiShoppingCart,
    'Baca buku': GiBookshelf,
    'Bersihkan mainan': GiToyMallet ,
  };

  const normalized = mission.name.trim();
  const Icon = iconMap[normalized] || GiBed;

  return (
    <div
      className={`bg-white rounded-2xl p-5 shadow-md border-l-8 transition-all duration-300 transform hover:scale-105 hover:shadow-xl ${
        mission.verified
          ? 'border-green-500'
          : mission.completed
          ? 'border-yellow-300'
          : 'border-yellow-500'
      }`}
    >
      <div className="flex items-start justify-between">
        <div className="flex items-start space-x-3">
          <Icon className="text-2xl text-yellow-500" />
          <div>
            <h3 className="font-bold text-base text-gray-800">{mission.name}</h3>
            <p className="text-green-500 font-bold mt-1 text-sm">+{mission.coins} koin</p>
          </div>
        </div>
        <div className="text-right">
          {mission.verified ? (
            <span className="bg-green-100 text-green-800 text-xs px-2 py-1 rounded-full font-bold">
              Selesai ✓
            </span>
          ) : mission.completed ? (
            <button
              onClick={() => onVerify(mission)}
              className="bg-yellow-100 hover:bg-yellow-200 text-yellow-800 font-bold py-1 px-3 rounded mt-1 text-xs transition"
            >
              Minta Verifikasi
            </button>
          ) : (
            <button
              onClick={() => onVerify(mission)}
              className="bg-yellow-500 hover:bg-yellow-400 text-white font-bold py-2 px-3 rounded mt-1 text-sm transition transform hover:scale-105"
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