import React, { useState } from 'react';

const ParentVerificationModal = ({ show, onClose, mission, onVerify }) => {
  const [pin, setPin] = useState('');

  const handlePinSubmit = () => {
    if (pin === '1234') {
      onVerify();
      onClose(); // Tutup modal setelah verifikasi berhasil
    } else {
      alert('PIN salah! Coba lagi');
    }
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
            />
            <button
              onClick={handlePinSubmit}
              className="w-full bg-green-500 hover:bg-green-600 text-white font-bold py-3 px-4 rounded-lg"
            >
              Verifikasi
            </button>
          </div>
        </div>

        <button
          onClick={onClose}
          className="w-full bg-gray-100 hover:bg-gray-200 text-gray-700 font-bold py-2 px-4 rounded-lg transition"
        >
          Batal
        </button>
      </div>
    </div>
  );
};

export default ParentVerificationModal;