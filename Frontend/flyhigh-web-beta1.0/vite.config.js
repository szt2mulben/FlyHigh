import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import { fileURLToPath, URL } from 'node:url'; // Importáljuk a szükséges modulokat

// https://vitejs.dev/config/
export default defineConfig({
  server: {
    host: '0.0.0.0', // Módosítsuk a szerver beállításait
  },
  plugins: [
    vue(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  }
});
