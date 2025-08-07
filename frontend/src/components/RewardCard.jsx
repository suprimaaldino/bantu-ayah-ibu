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
