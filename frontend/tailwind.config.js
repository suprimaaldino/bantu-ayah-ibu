// tailwind.config.js
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  theme: {
    extend: {
      backgroundColor: {
        'primary': '#FFD700',   // Kuning emas
        'secondary': '#4ADE8F', // Hijau neon
        'accent': '#FB7185',    // Pink cerah
        'bg': '#FEF9C3',        // Kuning soft latar
      },
      colors: {
        'primary': '#FFD700',
        'secondary': '#4ADE8F',
        'accent': '#FB7185',
      },
      borderRadius: {
        'xl': '0.75rem',
        '2xl': '1rem',
        '3xl': '1.5rem',
      },
      fontSize: {
        'xs': '0.75rem',
        'sm': '0.875rem',
        'base': '1rem',
        'lg': '1.125rem',
        'xl': '1.25rem',
        '2xl': '1.5rem',
      },
    },
  },
  plugins: [],
}