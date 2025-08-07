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
    const lastReset = Storage.getLastResetDate();

    if (!lastReset || lastReset !== today) {
      const defaultMissions = Storage.getMissions().map(m => ({
        ...m,
        completed: false,
        verified: false
      }));

      Storage.saveMissions(defaultMissions);
      Storage.saveLastResetDate(today);
      return { missions: defaultMissions, reset: true };
    }

    return { missions: Storage.getMissions(), reset: false };
  }
};